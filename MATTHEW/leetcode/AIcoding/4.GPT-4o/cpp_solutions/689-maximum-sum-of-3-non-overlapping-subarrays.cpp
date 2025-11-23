class Solution {
public:
    vector<int> maxSumOfThreeSubarrays(vector<int>& nums, int k) {
        int n = nums.size();
        vector<int> sum(n + 1, 0);
        for (int i = 0; i < n; ++i) {
            sum[i + 1] = sum[i] + nums[i];
        }

        vector<int> left(n, 0), right(n, 0);
        int maxSum = 0, idx = 0;

        for (int i = k - 1; i < n; ++i) {
            int currSum = sum[i + 1] - sum[i + 1 - k];
            if (currSum > maxSum) {
                maxSum = currSum;
                idx = i + 1 - k;
            }
            left[i] = idx;
        }

        maxSum = 0;
        idx = n - k;

        for (int i = n - k; i >= 0; --i) {
            int currSum = sum[i + k] - sum[i];
            if (currSum >= maxSum) {
                maxSum = currSum;
                idx = i;
            }
            right[i] = idx;
        }

        vector<int> result(3);
        maxSum = 0;

        for (int i = k - 1; i + k < n; ++i) {
            int leftIdx = left[i], rightIdx = right[i + 1];
            int totalSum = (sum[i + 1] - sum[i + 1 - k]) + (sum[rightIdx + k] - sum[rightIdx]);
            if (totalSum > maxSum) {
                maxSum = totalSum;
                result = {leftIdx, i + 1 - k, rightIdx};
            }
        }

        return result;
    }
};