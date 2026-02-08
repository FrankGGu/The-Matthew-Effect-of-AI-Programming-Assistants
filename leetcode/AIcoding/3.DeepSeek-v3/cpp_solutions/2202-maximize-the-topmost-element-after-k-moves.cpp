class Solution {
public:
    int maximumTop(vector<int>& nums, int k) {
        int n = nums.size();
        if (n == 1) {
            return k % 2 == 0 ? nums[0] : -1;
        }
        int max_val = -1;
        for (int i = 0; i < min(n, k + 1); ++i) {
            if (i != k - 1) {
                max_val = max(max_val, nums[i]);
            }
        }
        return max_val;
    }
};