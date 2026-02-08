class Solution {
public:
    int maxSum(vector<int>& nums, int k) {
        sort(nums.rbegin(), nums.rend());
        int sum = 0;
        for (int i = 0; i < k; ++i) {
            sum += nums[i];
        }
        return sum;
    }
};