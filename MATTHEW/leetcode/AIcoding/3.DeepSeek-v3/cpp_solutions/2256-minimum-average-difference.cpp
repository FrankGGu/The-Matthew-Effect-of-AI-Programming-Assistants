#include <vector>
#include <cmath>
#include <climits>
using namespace std;

class Solution {
public:
    int minimumAverageDifference(vector<int>& nums) {
        int n = nums.size();
        long long total = 0;
        for (int num : nums) {
            total += num;
        }

        long long minDiff = LLONG_MAX;
        int minIndex = -1;
        long long leftSum = 0;

        for (int i = 0; i < n; ++i) {
            leftSum += nums[i];
            long long leftAvg = leftSum / (i + 1);
            long long rightAvg = 0;

            if (i < n - 1) {
                rightAvg = (total - leftSum) / (n - i - 1);
            }

            long long diff = abs(leftAvg - rightAvg);
            if (diff < minDiff) {
                minDiff = diff;
                minIndex = i;
            }
        }

        return minIndex;
    }
};