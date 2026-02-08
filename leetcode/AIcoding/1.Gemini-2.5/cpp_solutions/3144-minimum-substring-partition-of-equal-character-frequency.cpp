#include <string>
#include <vector>
#include <algorithm> // For std::min

class Solution {
public:
    int minimumSubstringsInPartition(std::string s) {
        int n = s.length();
        // dp[i] stores the minimum number of partitions for the prefix s[0...i-1]
        // Initialize with n + 1, which is a value larger than any possible partition count (max is n)
        std::vector<int> dp(n + 1, n + 1);
        dp[0] = 0; // An empty prefix requires 0 partitions

        // Iterate through all possible end points of the prefix (exclusive)
        for (int i = 1; i <= n; ++i) {
            std::vector<int> freq(26, 0); // Frequency map for the current substring s[j...i-1]

            // Iterate backwards from i-1 to 0 to form substrings s[j...i-1]
            // This allows incremental updating of frequencies for the current substring
            for (int j = i - 1; j >= 0; --j) {
                freq[s[j] - 'a']++; // Add character s[j] to the current substring

                // Check if the current substring s[j...i-1] is valid
                // A substring is valid if all its distinct characters have the same frequency
                int target_freq = -1;
                bool is_valid_substring = true;
                for (int k = 0; k < 26; ++k) {
                    if (freq[k] == 0) {
                        continue; // Character not present in the substring
                    }
                    if (target_freq == -1) {
                        target_freq = freq[k]; // Set target frequency from the first distinct character found
                    } else if (freq[k] != target_freq) {
                        is_valid_substring = false; // Frequencies of distinct characters do not match
                        break;
                    }
                }

                if (is_valid_substring) {
                    // If s[j...i-1] is a valid partition, update dp[i]
                    // It's 1 (for this current valid partition) + dp[j] (for the minimum partitions of the prefix s[0...j-1])
                    dp[i] = std::min(dp[i], 1 + dp[j]);
                }
            }
        }

        return dp[n]; // The minimum partitions for the entire string s[0...n-1]
    }
};