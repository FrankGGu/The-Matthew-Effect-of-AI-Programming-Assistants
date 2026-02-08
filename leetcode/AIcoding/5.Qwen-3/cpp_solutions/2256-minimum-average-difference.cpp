#include <iostream>
#include <vector>
#include <cmath>

using namespace std;

class Solution {
public:
    int minimumAverageDifference(int n, vector<int>& nums) {
        long long total = 0;
        for (int num : nums) {
            total += num;
        }

        long long leftSum = 0;
        int minIndex = 0;
        int minDiff = INT_MAX;
        for (int i = 0; i < n; ++i) {
            leftSum += nums[i];
            long long rightSum = total - leftSum;
            int leftCount = i + 1;
            int rightCount = n - i - 1;

            long long leftAvg = leftSum / leftCount;
            long long rightAvg = (rightCount == 0) ? 0 : rightSum / rightCount;

            int diff = abs(leftAvg - rightAvg);
            if (diff < minDiff) {
                minDiff = diff;
                minIndex = i;
            }
        }
        return minIndex;
    }
};