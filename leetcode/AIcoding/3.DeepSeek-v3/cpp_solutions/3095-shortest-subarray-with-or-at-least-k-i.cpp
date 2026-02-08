class Solution {
public:
    int minimumSubarrayLength(vector<int>& nums, int k) {
        int n = nums.size();
        int min_len = INT_MAX;

        for (int i = 0; i < n; ++i) {
            int current_or = 0;
            for (int j = i; j < n; ++j) {
                current_or |= nums[j];
                if (current_or >= k) {
                    min_len = min(min_len, j - i + 1);
                    break;
                }
            }
        }

        return min_len == INT_MAX ? -1 : min_len;
    }
};