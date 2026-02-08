import java.util.*;

class Solution {
    private static final long INF = Long.MAX_VALUE / 2; // Use a large value for infinity to avoid overflow during addition

    // Polynomial rolling hash parameters
    private static final long P1 = 31; // A prime base
    private static final long M1 = 1_000_000_007; // A large prime modulus

    // Function to calculate hash of a string (backward hash: char at index 0 has highest power)
    private long getHash(String s) {
        long hash = 0;
        for (int i = 0; i < s.length(); i++) {
            hash = (hash * P1 + (s.charAt(i) - 'a' + 1)) % M1;
        }
        return hash;
    }

    // Function to get hash of a substring using rolling hash (for backward hash)
    private long getSubstringHash(long[] hashes, int start, int end, long[] powers) {
        // hashes[k] stores hash of prefix s[0...k-1]
        // hash(s[0...k-1]) = (s[0]*P^(k-1) + s[1]*P^(k-2) + ... + s[k-1]*P^0) % M
        // substring s[start...end-1]
        // hash(s[start...end-1]) = (hashes[end] - hashes[start] * powers[end - start] % M + M) % M
        long subHash = (hashes[end] - (hashes[start] * powers[end - start]) % M1 + M1) % M1;
        return subHash;
    }

    public long minimumCost(String source, String target, char[] original_chars, char[] changed_chars, int[] costs_chars, String[] original_strings, String[] changed_strings, int[] costs_strings) {
        int N = source.length();

        // 1. Floyd-Warshall for character conversion costs
        long[][] charConversionCost = new long[26][26];
        for (int i = 0; i < 26; i++) {
            Arrays.fill(charConversionCost[i], INF);
            charConversionCost[i][i] = 0;
        }

        for (int i = 0; i < original_chars.length; i++) {
            int u = original_chars[i] - 'a';
            int v = changed_chars[i] - 'a';
            charConversionCost[u][v] = Math.min(charConversionCost[u][v], (long) costs_chars[i]);
        }

        for (int k = 0; k < 26; k++) { // Intermediate character
            for (int i = 0; i < 26; i++) { // Start character
                for (int j = 0; j < 26; j++) { // End character
                    if (charConversionCost[i][k] != INF && charConversionCost[k][j] != INF) {
                        charConversionCost[i][j] = Math.min(charConversionCost[i][j], charConversionCost[i][k] + charConversionCost[k][j]);
                    }
                }
            }
        }

        // 2. Precompute minimum costs for string conversions
        // Use a temporary map with String keys to aggregate direct costs and char-by-char costs
        Map<String, Map<String, Long>> stringMinSubstringCost = new HashMap<>();
        int maxLen = 0; // To optimize DP loop, track max length of original strings

        for (int i = 0; i < original_strings.length; i++) {
            String o_str = original_strings[i];
            String c_str = changed_strings[i];
            long cost_val = (long) costs_strings[i];

            stringMinSubstringCost.computeIfAbsent(o_str, k -> new HashMap<>())
                                  .merge(c_str, cost_val, Math::min);
            maxLen = Math.max(maxLen, o_str.length());
        }

        // Calculate char-by-char conversion costs for each (original_string, changed_string) pair
        // and update stringMinSubstringCost if it's cheaper
        for (Map.Entry<String, Map<String, Long>> entry_o : stringMinSubstringCost.entrySet()) {
            String o_str = entry_o.getKey();
            for (Map.Entry<String, Long> entry_c : entry_o.getValue().entrySet()) {
                String c_str = entry_c.getKey();

                if (o_str.length() != c_str.length()) { 
                    // Problem implies original[i] and changed[i] have same length
                    // If not, this pair cannot be used for substring conversion
                    continue; 
                }

                long current_char_by_char_cost = 0;
                boolean possible = true;
                for (int p = 0; p < o_str.length(); p++) {
                    int char1 = o_str.charAt(p) - 'a';
                    int char2 = c_str.charAt(p) - 'a';
                    if (charConversionCost[char1][char2] == INF) {
                        possible = false;
                        break;
                    }
                    current_char_by_char_cost += charConversionCost[char1][char2];
                    if (current_char_by_char_cost >= INF) { // Prevent overflow if sum exceeds INF
                        current_char_by_char_cost = INF;
                        break;
                    }
                }

                if (possible) {
                    entry_o.getValue().merge(c_str, current_char_by_char_cost, Math::min);
                }
            }
        }

        // Convert stringMinSubstringCost to hashMinSubstringCost for O(1) average lookup in DP
        Map<Long, Map<Long, Long>> hashMinSubstringCost = new HashMap<>();
        for (Map.Entry<String, Map<String, Long>> entry_o : stringMinSubstringCost.entrySet()) {
            String o_str = entry_o.getKey();
            long h_o = getHash(o_str);
            for (Map.Entry<String, Long> entry_c : entry_o.getValue().entrySet()) {
                String c_str = entry_c.getKey();
                long h_c = getHash(c_str);
                hashMinSubstringCost.computeIfAbsent(h_o, k -> new HashMap<>())
                                    .put(h_c, entry_c.getValue());
            }
        }

        // 3. Dynamic Programming
        long[] dp = new long[N + 1];
        Arrays.fill(dp, INF);
        dp[0] = 0; // Cost to convert empty prefix is 0

        // Precompute powers of P1 for rolling hash
        long[] powers = new long[N + 1];
        powers[0] = 1;
        for (int i = 1; i <= N; i++) {
            powers[i] = (powers[i - 1] * P1) % M1;
        }

        // Precompute rolling hashes for source and target strings
        long[] sourceHashes = new long[N + 1];
        long[] targetHashes = new long[N + 1];
        for (int i = 1; i <= N; i++) {
            sourceHashes[i] = (sourceHashes[i - 1] * P1 + (source.charAt(i - 1) - 'a' + 1)) % M1;
            targetHashes[i] = (targetHashes[i - 1] * P1 + (target.charAt(i - 1) - 'a' + 1)) % M1;
        }

        for (int i = 1; i <= N; i++) {
            // Option 1: Convert single character source[i-1] to target[i-1]
            if (dp[i - 1] != INF) {
                int s_char_idx = source.charAt(i - 1) - 'a';
                int t_char_idx = target.charAt(i - 1) - 'a';
                long char_cost = charConversionCost[s_char_idx][t_char_idx];
                if (char_cost != INF) {
                    dp[i] = Math.min(dp[i], dp[i - 1] + char_cost);
                }
            }

            // Option 2: Convert substring source[j...i-1] to target[j...i-1] using a given (original, changed) pair
            // Iterate over possible lengths `len` of substrings
            for (int len = 1; len <= maxLen && i - len >= 0; len++) {
                int j = i - len; // Starting index of the substring

                if (dp[j] == INF) { // Cannot reach this state
                    continue;
                }

                long s_sub_hash = getSubstringHash(sourceHashes, j, i, powers);
                long t_sub_hash = getSubstringHash(targetHashes, j, i, powers);

                if (hashMinSubstringCost.containsKey(s_sub_hash)) {
                    Map<Long, Long> innerMap = hashMinSubstringCost.get(s_sub_hash);
                    if (innerMap.containsKey(t_sub_hash)) {
                        long cost_sub = innerMap.get(t_sub_hash);
                        if (cost_sub != INF) {
                            dp[i] = Math.min(dp[i], dp[j] + cost_sub);
                        }
                    }
                }
            }
        }

        return dp[N] == INF ? -1 : dp[N];
    }
}