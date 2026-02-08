class Solution {
public:
    int maxSum(vector<int>& nums, int k) {
        sort(nums.rbegin(), nums.rend());
        int max_sum = 0;
        for (int i = 0; i < k; ++i) {
            max_sum += nums[i];
        }
        return max_sum;
    }
};