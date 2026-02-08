class Solution {
public:
    int longestAlternatingSubarray(vector<int>& nums, int threshold) {
        int max_len = 0;
        int n = nums.size();
        for (int i = 0; i < n; ++i) {
            if (nums[i] % 2 == 0 && nums[i] <= threshold) {
                int len = 1;
                for (int j = i + 1; j < n; ++j) {
                    if (nums[j] % 2 != nums[j - 1] % 2 && nums[j] <= threshold) {
                        len++;
                    } else {
                        break;
                    }
                }
                max_len = max(max_len, len);
            }
        }
        return max_len;
    }
};