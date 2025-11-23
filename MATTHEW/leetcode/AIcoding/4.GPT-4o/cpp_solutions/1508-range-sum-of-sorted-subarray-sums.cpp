class Solution {
public:
    int rangeSum(vector<int>& nums, int n, int left, int right) {
        vector<long long> sums;
        for (int i = 0; i < n; ++i) {
            long long currentSum = 0;
            for (int j = i; j < n; ++j) {
                currentSum += nums[j];
                sums.push_back(currentSum);
            }
        }
        sort(sums.begin(), sums.end());
        long long result = 0;
        for (int i = left - 1; i < right; ++i) {
            result = (result + sums[i]) % 1000000007;
        }
        return result;
    }
};