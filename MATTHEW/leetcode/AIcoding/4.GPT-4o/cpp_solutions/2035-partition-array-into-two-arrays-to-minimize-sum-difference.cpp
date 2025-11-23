class Solution {
public:
    int minimumDifference(vector<int>& nums) {
        int totalSum = accumulate(nums.begin(), nums.end(), 0);
        int n = nums.size() / 2;
        vector<int> leftSums(1 << n);
        for (int i = 0; i < (1 << n); ++i) {
            for (int j = 0; j < n; ++j) {
                if (i & (1 << j)) {
                    leftSums[i] += nums[j];
                }
            }
        }

        vector<int> rightSums(1 << n);
        for (int i = 0; i < (1 << n); ++i) {
            for (int j = 0; j < n; ++j) {
                if (i & (1 << j)) {
                    rightSums[i] += nums[j + n];
                }
            }
        }

        sort(rightSums.begin(), rightSums.end());
        int minDiff = INT_MAX;

        for (int leftSum : leftSums) {
            int target = totalSum / 2 - leftSum;
            auto it = lower_bound(rightSums.begin(), rightSums.end(), target);
            if (it != rightSums.end()) {
                minDiff = min(minDiff, abs(totalSum - 2 * (leftSum + *it)));
            }
            if (it != rightSums.begin()) {
                --it;
                minDiff = min(minDiff, abs(totalSum - 2 * (leftSum + *it)));
            }
        }

        return minDiff;
    }
};