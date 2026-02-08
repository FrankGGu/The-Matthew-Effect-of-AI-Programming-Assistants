class Solution {
public:
    int alternatingSubarray(vector<int>& nums) {
        int max_len = -1;
        int n = nums.size();
        for (int i = 0; i < n; ++i) {
            for (int j = i + 1; j < n; ++j) {
                if (nums[j] - nums[i] == (j - i) % 2) {
                    if (j - i + 1 > max_len) {
                        max_len = j - i + 1;
                    }
                } else {
                    break;
                }
            }
        }
        return max_len;
    }
};