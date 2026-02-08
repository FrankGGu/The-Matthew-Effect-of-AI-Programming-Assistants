class Solution {
    public int minimumSubstringsInPartition(String s) {
        int n = s.length();
        int[] dp = new int[n + 1];

        // dp[i] will store the minimum partitions for the prefix s[0...i-1]
        // dp[0] = 0, as an empty string requires 0 partitions.
        dp[0] = 0;

        // Initialize dp[i] for i > 0.
        // The maximum possible partitions is n (each character forms its own partition).
        // This also serves as an initial large value.
        for (int i = 1; i <= n; i++) {
            dp[i] = i; 
        }

        // Iterate through all possible end points of a prefix
        for (int i = 1; i <= n; i++) {
            int[] freq = new int[26]; // Frequency map for the current substring s[j...i-1]

            // Iterate backwards from i-1 down to 0 to find all possible start points (j)
            // for a substring ending at i-1.
            // s[j...i-1] is the current substring being considered.
            for (int j = i - 1; j >= 0; j--) {
                char c = s.charAt(j);
                freq[c - 'a']++; // Add character s[j] to the frequency map

                // Check if the current substring s[j...i-1] is valid.
                // A substring is valid if all characters present in it have the same frequency.
                boolean currentSubstringIsValid = true;
                int firstNonZeroFreq = 0; // Stores the frequency of the first character encountered

                for (int k = 0; k < 26; k++) {
                    if (freq[k] > 0) { // If character 'a'+k is present in the substring
                        if (firstNonZeroFreq == 0) {
                            firstNonZeroFreq = freq[k]; // Set the target frequency
                        } else if (freq[k] != firstNonZeroFreq) {
                            // If any other present character has a different frequency, it's not valid
                            currentSubstringIsValid = false;
                            break;
                        }
                    }
                }

                // If the current substring s[j...i-1] is valid,
                // we can potentially form a partition ending at i-1.
                // The cost would be dp[j] (minimum partitions for the prefix s[0...j-1])
                // plus 1 (for the current valid substring s[j...i-1]).
                if (currentSubstringIsValid) {
                    dp[i] = Math.min(dp[i], dp[j] + 1);
                }
            }
        }

        return dp[n]; // dp[n] contains the minimum partitions for the entire string s[0...n-1]
    }
}