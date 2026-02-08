class Solution {
public:
    int maxSumTwoNoOverlap(vector<int>& nums, int firstLen, int secondLen) {
        int n = nums.size();
        vector<int> prefix(n + 1, 0);
        for (int i = 0; i < n; ++i) {
            prefix[i + 1] = prefix[i] + nums[i];
        }

        int maxSum = 0;
        for (int i = firstLen; i <= n; ++i) {
            int firstSum = prefix[i] - prefix[i - firstLen];
            for (int j = 0; j <= n - secondLen; ++j) {
                if (j + secondLen <= i && j + secondLen > i - firstLen) continue;
                int secondSum = prefix[j + secondLen] - prefix[j];
                maxSum = max(maxSum, firstSum + secondSum);
            }
        }

        for (int i = secondLen; i <= n; ++i) {
            int secondSum = prefix[i] - prefix[i - secondLen];
            for (int j = 0; j <= n - firstLen; ++j) {
                if (j + firstLen <= i && j + firstLen > i - secondLen) continue;
                int firstSum = prefix[j + firstLen] - prefix[j];
                maxSum = max(maxSum, firstSum + secondSum);
            }
        }

        return maxSum;
    }
};