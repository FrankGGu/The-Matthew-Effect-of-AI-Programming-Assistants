public class Solution {

import java.util.*;

public class Solution {
    public int countKSubsequence(string s, int k) {
        int mod = 1000000007;
        Map<Character, Integer> freq = new HashMap<>();
        for (char c : s.toCharArray()) {
            freq.put(c, freq.getOrDefault(c, 0) + 1);
        }
        List<Map.Entry<Character, Integer>> entries = new ArrayList<>(freq.entrySet());
        entries.sort((a, b) -> b.getValue() - a.getValue());

        long res = 1;
        int total = 0;
        for (Map.Entry<Character, Integer> entry : entries) {
            total += entry.getValue();
        }

        if (total < k) return 0;

        int[] counts = new int[entries.size()];
        for (int i = 0; i < entries.size(); i++) {
            counts[i] = entries.get(i).getValue();
        }

        Arrays.sort(counts);

        int[] freqs = new int[26];
        for (int i = 0; i < entries.size(); i++) {
            freqs[entries.get(i).getKey() - 'a'] = counts[i];
        }

        int maxFreq = 0;
        for (int f : freqs) {
            maxFreq = Math.max(maxFreq, f);
        }

        int cntMax = 0;
        for (int f : freqs) {
            if (f == maxFreq) cntMax++;
        }

        int remaining = k;
        long ways = 1;
        for (int i = 0; i < 26; i++) {
            if (freqs[i] == 0) continue;
            if (remaining == 0) break;
            if (freqs[i] > 0) {
                ways = ways * freqs[i] % mod;
                remaining--;
            }
        }

        if (remaining > 0) {
            int need = remaining;
            int[] freqCopy = Arrays.copyOf(freqs, 26);
            Arrays.sort(freqCopy);
            int min = freqCopy[26 - need];
            int countMin = 0;
            for (int f : freqs) {
                if (f == min) countMin++;
            }
            ways = ways * combination(countMin, need) % mod;
        }

        return (int) ways;
    }

    private long combination(int n, int k) {
        long mod = 1000000007;
        long[][] dp = new long[n + 1][k + 1];
        for (int i = 0; i <= n; i++) {
            dp[i][0] = 1;
        }
        for (int i = 1; i <= n; i++) {
            for (int j = 1; j <= k; j++) {
                dp[i][j] = (dp[i - 1][j] + dp[i - 1][j - 1]) % mod;
            }
        }
        return dp[n][k];
    }
}
}