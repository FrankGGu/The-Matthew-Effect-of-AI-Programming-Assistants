class Solution {
public:
    int minKBitFlips(std::vector<int>& nums, int k) {
        int n = nums.size();
        int flip_count = 0; // Tracks the number of active flips affecting the current position
        int ans = 0;        // Stores the total number of flips performed

        // This array marks if a flip started at index i.
        // 1 means a flip started, 0 means no flip started.
        // This is used to decrement flip_count when a flip's effect ends.
        std::vector<int> is_flipped_start(n, 0); 

        for (int i = 0; i < n; ++i) {
            // If a flip started K positions ago (at i-K), its effect ends before or at current position i.
            // So, we decrement the active flip count.
            if (i >= k) {
                flip_count -= is_flipped_start[i - k];
            }

            // Determine the effective value of nums[i] considering active flips.
            // If original nums[i] is 0 and flip_count is even, effective value is 0.
            // If original nums[i] is 0 and flip_count is odd, effective value is 1.
            // If original nums[i] is 1 and flip_count is even, effective value is 1.
            // If original nums[i] is 1 and flip_count is odd, effective value is 0.
            // This can be simplified to (nums[i] + flip_count) % 2.
            if ((nums[i] + flip_count) % 2 == 0) { // If the effective bit is 0, we must flip
                // Check if a K-consecutive flip starting at i is possible
                if (i + k > n) {
                    return -1; // Not enough elements left to perform a K-flip
                }

                // Perform the flip
                ans++;
                flip_count++;
                is_flipped_start[i] = 1; // Mark that a flip started at this index
            }
        }

        return ans;
    }
};