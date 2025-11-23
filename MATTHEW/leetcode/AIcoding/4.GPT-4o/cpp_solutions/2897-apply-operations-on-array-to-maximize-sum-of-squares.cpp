class Solution {
public:
    long long maximizeSum(vector<int>& nums, int k) {
        long long sum = 0;
        sort(nums.rbegin(), nums.rend());
        for (int i = 0; i < k; ++i) {
            sum += nums[i];
        }
        return sum * sum;
    }
};