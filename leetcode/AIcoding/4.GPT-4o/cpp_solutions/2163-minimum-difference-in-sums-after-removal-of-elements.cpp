class Solution {
public:
    int minimumDifference(vector<int>& nums) {
        int n = nums.size() / 2;
        int totalSum = accumulate(nums.begin(), nums.end(), 0);
        vector<int> leftSums(1 << n), rightSums(1 << n);

        for (int mask = 0; mask < (1 << n); ++mask) {
            for (int i = 0; i < n; ++i) {
                if (mask & (1 << i)) {
                    leftSums[mask] += nums[i];
                }
            }
        }

        for (int mask = 0; mask < (1 << n); ++mask) {
            for (int i = 0; i < n; ++i) {
                if (mask & (1 << i)) {
                    rightSums[mask] += nums[n + i];
                }
            }
        }

        sort(rightSums.begin(), rightSums.end());
        int minDiff = INT_MAX;

        for (int sum : leftSums) {
            int target = (totalSum - sum) / 2;
            int idx = lower_bound(rightSums.begin(), rightSums.end(), target) - rightSums.begin();

            if (idx < rightSums.size()) {
                minDiff = min(minDiff, abs(totalSum - 2 * (sum + rightSums[idx])));
            }
            if (idx > 0) {
                minDiff = min(minDiff, abs(totalSum - 2 * (sum + rightSums[idx - 1])));
            }
        }

        return minDiff;
    }
};