class Solution {
public:
    int longestSubarray(vector<int>& nums) {
        int left = 0, right = 0;
        int max_len = 0;
        int zero_count = 0;

        while (right < nums.size()) {
            if (nums[right] == 0) {
                zero_count++;
            }

            while (zero_count > 1) {
                if (nums[left] == 0) {
                    zero_count--;
                }
                left++;
            }

            max_len = max(max_len, right - left);
            right++;
        }

        return max_len;
    }
};