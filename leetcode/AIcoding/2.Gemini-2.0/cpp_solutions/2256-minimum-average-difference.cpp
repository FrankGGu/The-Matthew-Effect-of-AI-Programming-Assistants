#include <vector>
#include <numeric>
#include <algorithm>

using namespace std;

class Solution {
public:
    int minimumAverageDifference(vector<int>& nums) {
        int n = nums.size();
        vector<long long> prefixSum(n + 1, 0);
        for (int i = 0; i < n; ++i) {
            prefixSum[i + 1] = prefixSum[i] + nums[i];
        }

        long long minAvgDiff = -1;
        int minIndex = -1;

        for (int i = 0; i < n; ++i) {
            long long leftSum = prefixSum[i + 1];
            long long rightSum = prefixSum[n] - prefixSum[i + 1];

            long long leftAvg = leftSum / (i + 1);
            long long rightAvg = (i == n - 1) ? 0 : rightSum / (n - i - 1);

            long long avgDiff = abs(leftAvg - rightAvg);

            if (minAvgDiff == -1 || avgDiff < minAvgDiff) {
                minAvgDiff = avgDiff;
                minIndex = i;
            }
        }

        return minIndex;
    }
};