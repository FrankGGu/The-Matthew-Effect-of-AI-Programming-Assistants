class Solution {
public:
    int minimumSubarrayLength(vector<int>& nums, int k) {
        int n = nums.size();
        int min_len = INT_MAX;
        vector<int> bits(32, 0);
        int left = 0;
        int current_or = 0;

        for (int right = 0; right < n; ++right) {
            current_or |= nums[right];
            for (int i = 0; i < 32; ++i) {
                if (nums[right] & (1 << i)) {
                    bits[i]++;
                }
            }

            while (left <= right && current_or >= k) {
                min_len = min(min_len, right - left + 1);
                for (int i = 0; i < 32; ++i) {
                    if (nums[left] & (1 << i)) {
                        bits[i]--;
                        if (bits[i] == 0) {
                            current_or &= ~(1 << i);
                        }
                    }
                }
                left++;
            }
        }

        return min_len == INT_MAX ? -1 : min_len;
    }
};