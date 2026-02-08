class Solution {
public:
    int maxSumMinProduct(vector<int>& nums) {
        int n = nums.size();
        vector<long long> prefixSum(n + 1, 0);
        for (int i = 0; i < n; ++i) {
            prefixSum[i + 1] = prefixSum[i] + nums[i];
        }

        stack<int> s;
        long long maxProduct = 0;

        for (int i = 0; i <= n; ++i) {
            while (!s.empty() && (i == n || nums[s.top()] > nums[i])) {
                int j = s.top();
                s.pop();
                long long sum = prefixSum[i] - prefixSum[s.empty() ? 0 : s.top() + 1];
                maxProduct = max(maxProduct, sum * nums[j]);
            }
            s.push(i);
        }

        return maxProduct % 1000000007;
    }
};