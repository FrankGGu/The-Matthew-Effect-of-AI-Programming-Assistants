class Solution {
public:
    int rangeSum(vector<int>& nums, int n, int left, int right) {
        vector<int> subarraySums;
        for (int i = 0; i < n; ++i) {
            int sum = 0;
            for (int j = i; j < n; ++j) {
                sum += nums[j];
                subarraySums.push_back(sum);
            }
        }
        sort(subarraySums.begin(), subarraySums.end());
        long long res = 0;
        for (int i = left - 1; i < right; ++i) {
            res += subarraySums[i];
        }
        return res % 1000000007;
    }
};