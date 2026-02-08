class Solution {
public:
    int minimumAverageDifference(vector<int>& nums) {
        int n = nums.size();
        long long total = accumulate(nums.begin(), nums.end(), 0LL);
        long long leftSum = 0;
        int minIndex = 0;
        long long minDiff = LLONG_MAX;

        for (int i = 0; i < n; ++i) {
            leftSum += nums[i];
            long long rightSum = total - leftSum;
            long long leftAvg = leftSum / (i + 1);
            long long rightAvg = (i == n - 1) ? 0 : rightSum / (n - i - 1);
            long long diff = abs(leftAvg - rightAvg);

            if (diff < minDiff) {
                minDiff = diff;
                minIndex = i;
            }
        }

        return minIndex;
    }
};