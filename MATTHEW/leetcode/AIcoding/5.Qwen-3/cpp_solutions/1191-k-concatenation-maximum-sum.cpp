#include <iostream>
#include <vector>
#include <climits>

using namespace std;

class Solution {
public:
    int kConcatenationSum(vector<int>& arr, int k) {
        int n = arr.size();
        long maxEndingHere = arr[0];
        long maxSoFar = arr[0];
        for (int i = 1; i < n; ++i) {
            maxEndingHere = max((long)arr[i], maxEndingHere + arr[i]);
            maxSoFar = max(maxSoFar, maxEndingHere);
        }

        if (k == 1) {
            return (int)maxSoFar;
        }

        long totalSum = 0;
        for (int num : arr) {
            totalSum += num;
        }

        long maxPrefix = arr[0];
        long currentPrefix = arr[0];
        for (int i = 1; i < n; ++i) {
            currentPrefix += arr[i];
            maxPrefix = max(maxPrefix, currentPrefix);
        }

        long maxSuffix = arr[n-1];
        long currentSuffix = arr[n-1];
        for (int i = n-2; i >= 0; --i) {
            currentSuffix += arr[i];
            maxSuffix = max(maxSuffix, currentSuffix);
        }

        long maxTwoTimes = maxPrefix + maxSuffix;
        return (int)max(maxSoFar, maxTwoTimes + (k - 2) * totalSum);
    }
};