class Solution {
public:
    int maxSumPair(vector<int>& nums) {
        sort(nums.begin(), nums.end());
        int maxPairSum = 0;
        int n = nums.size();
        for (int i = 0; i < n / 2; ++i) {
            maxPairSum = max(maxPairSum, nums[i] + nums[n - 1 - i]);
        }
        return maxPairSum;
    }
};