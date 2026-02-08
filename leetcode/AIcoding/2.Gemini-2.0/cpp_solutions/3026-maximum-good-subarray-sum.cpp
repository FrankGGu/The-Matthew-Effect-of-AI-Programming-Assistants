#include <vector>
#include <climits>
#include <numeric>
#include <map>

using namespace std;

long long maximumSubarraySum(vector<int>& nums, int k) {
    long long maxSum = LLONG_MIN;
    map<int, long long> prefixSumMap;
    long long currentSum = 0;

    for (int num : nums) {
        currentSum += num;

        if (prefixSumMap.count(num + k)) {
            maxSum = max(maxSum, currentSum - prefixSumMap[num + k]);
        }
        if (prefixSumMap.count(num - k)) {
            maxSum = max(maxSum, currentSum - prefixSumMap[num - k]);
        }

        if (!prefixSumMap.count(num)) {
            prefixSumMap[num] = currentSum;
        } else {
            prefixSumMap[num] = min(prefixSumMap[num], currentSum);
        }
    }

    return maxSum == LLONG_MIN ? 0 : maxSum;
}