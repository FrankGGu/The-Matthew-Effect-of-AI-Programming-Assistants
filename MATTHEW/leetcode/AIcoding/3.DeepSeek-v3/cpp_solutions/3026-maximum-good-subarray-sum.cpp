#include <vector>
#include <unordered_map>
#include <climits>
#include <algorithm>

using namespace std;

class Solution {
public:
    long long maximumSubarraySum(vector<int>& nums, int k) {
        unordered_map<int, long long> prefixSumMap;
        prefixSumMap[0] = 0;
        long long prefixSum = 0;
        long long maxSum = LLONG_MIN;

        for (int i = 0; i < nums.size(); ++i) {
            prefixSum += nums[i];
            if (prefixSumMap.count(prefixSum - k)) {
                long long currentSum = prefixSum - prefixSumMap[prefixSum - k];
                if (currentSum > maxSum) {
                    maxSum = currentSum;
                }
            }
            if (!prefixSumMap.count(prefixSum) || prefixSumMap[prefixSum] > prefixSum) {
                prefixSumMap[prefixSum] = prefixSum;
            }
        }

        return maxSum == LLONG_MIN ? 0 : maxSum;
    }
};