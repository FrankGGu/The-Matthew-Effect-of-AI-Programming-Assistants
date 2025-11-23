class Solution {
public:
    long long findXSum(vector<int>& nums, int k) {
        int n = nums.size();
        vector<long long> prefix(n + 1, 0);
        for (int i = 0; i < n; ++i) {
            prefix[i + 1] = prefix[i] + nums[i];
        }
        long long result = 0;
        for (int i = 0; i <= n - k; ++i) {
            result += prefix[i + k] - prefix[i];
        }
        return result;
    }
};