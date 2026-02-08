class Solution {
public:
    int maxSumTwoNoOverlap(vector<int>& nums, int firstLen, int secondLen) {
        int n = nums.size();
        vector<int> prefix(n + 1, 0);
        for (int i = 0; i < n; ++i) {
            prefix[i + 1] = prefix[i] + nums[i];
        }

        auto maxSum = [&](int L, int M) {
            int maxL = 0, res = 0;
            for (int i = L + M; i <= n; ++i) {
                maxL = max(maxL, prefix[i - M] - prefix[i - M - L]);
                res = max(res, maxL + prefix[i] - prefix[i - M]);
            }
            return res;
        };

        return max(maxSum(firstLen, secondLen), maxSum(secondLen, firstLen));
    }
};