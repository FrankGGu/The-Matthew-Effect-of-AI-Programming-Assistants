class Solution {
public:
    long long maxScore(vector<int>& nums) {
        int n = nums.size();
        vector<long long> prefixSum(n + 1, 0);
        for (int i = 0; i < n; ++i) {
            prefixSum[i + 1] = prefixSum[i] + nums[i];
        }

        long long maxScore = 0;
        for (int i = 0; i < n; ++i) {
            maxScore = max(maxScore, prefixSum[i + 1] - (long long)(i + 1) * nums[i]);
        }

        return maxScore;
    }
};