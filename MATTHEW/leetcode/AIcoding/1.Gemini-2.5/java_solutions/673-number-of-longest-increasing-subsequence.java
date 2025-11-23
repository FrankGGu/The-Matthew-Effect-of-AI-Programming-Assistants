class Solution {
    public int findNumberOfLIS(int[] nums) {
        int n = nums.length;
        if (n == 0) {
            return 0;
        }

        int[] dp_len = new int[n];    // dp_len[i] stores the length of the longest increasing subsequence ending at index i
        int[] dp_count = new int[n];  // dp_count[i] stores the number of longest increasing subsequences of length dp_len[i] ending at index i

        // Initialize all dp_len and dp_count values
        // A single element itself forms an LIS of length 1, with count 1
        for (int i = 0; i < n; i++) {
            dp_len[i] = 1;
            dp_count[i] = 1;
        }

        // Fill the dp_len and dp_count arrays
        for (int i = 0; i < n; i++) {
            for (int j = 0; j < i; j++) {
                if (nums[i] > nums[j]) {
                    // If we can extend an LIS ending at j
                    if (dp_len[j] + 1 > dp_len[i]) {
                        // Found a strictly longer LIS ending at i
                        dp_len[i] = dp_len[j] + 1;
                        dp_count[i] = dp_count[j]; // Reset count, as this is a new longest length
                    } else if (dp_len[j] + 1 == dp_len[i]) {
                        // Found another LIS of the same current longest length ending at i
                        dp_count[i] += dp_count[j]; // Add the count from j
                    }
                }
            }
        }

        // Find the maximum length among all LIS
        int max_len = 0;
        for (int len : dp_len) {
            max_len = Math.max(max_len, len);
        }

        // Sum up the counts of all LIS that achieve the maximum length
        int result = 0;
        for (int i = 0; i < n; i++) {
            if (dp_len[i] == max_len) {
                result += dp_count[i];
            }
        }

        return result;
    }
}