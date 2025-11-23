#include <vector>
#include <numeric>
#include <map>
#include <algorithm>

class Solution {
public:
    int waysToPartition(std::vector<int>& nums, int k) {
        int n = nums.size();

        std::vector<long long> prefixSum(n + 1, 0);
        for (int i = 0; i < n; ++i) {
            prefixSum[i+1] = prefixSum[i] + nums[i];
        }
        long long totalSum = prefixSum[n];

        int initialWays = 0;
        if (totalSum % 2 == 0) {
            long long targetHalfSum = totalSum / 2;
            for (int p = 1; p < n; ++p) {
                if (prefixSum[p] == targetHalfSum) {
                    initialWays++;
                }
            }
        }
        int maxWays = initialWays;

        std::map<long long, int> left_map;  // Stores counts of prefixSum[p] for 1 <= p <= i
        std::map<long long, int> right_map; // Stores counts of prefixSum[p] for i+1 <= p < n

        // Initially, for i=0, left_map is empty.
        // right_map contains all possible prefix sums for partitions p from 1 to n-1.
        for (int p = 1; p < n; ++p) {
            right_map[prefixSum[p]]++;
        }

        for (int i = 0; i < n; ++i) { // i is the index of the element to change
            long long newTotalSum = totalSum - nums[i] + k;

            if (newTotalSum % 2 == 0) {
                long long targetHalfSum = newTotalSum / 2;
                int currentWays = 0;

                // Case 1: Partition point p is such that 1 <= p <= i.
                // The changed element nums[i] is in the second part (nums[p...n-1]).
                // The sum of the first part is prefixSum[p].
                // We need prefixSum[p] == targetHalfSum.
                if (left_map.count(targetHalfSum)) {
                    currentWays += left_map[targetHalfSum];
                }

                // Case 2: Partition point p is such that i+1 <= p < n.
                // The changed element nums[i] is in the first part (nums[0...p-1]).
                // The sum of the first part changes to prefixSum[p] - nums[i] + k.
                // We need prefixSum[p] - nums[i] + k == targetHalfSum.
                // So, prefixSum[p] == targetHalfSum + nums[i] - k.
                long long requiredPrefixSumForRight = targetHalfSum + nums[i] - k;
                if (right_map.count(requiredPrefixSumForRight)) {
                    currentWays += right_map[requiredPrefixSumForRight];
                }
                maxWays = std::max(maxWays, currentWays);
            }

            // After processing index i, prepare maps for the next iteration (i+1).
            // The prefix sum prefixSum[i+1] (sum of nums[0]...nums[i])
            // now represents a partition point p = i+1, which is "left" of the new i.
            // So, prefixSum[i+1] moves from right_map to left_map.
            if (i + 1 < n) {
                right_map[prefixSum[i+1]]--;
                if (right_map[prefixSum[i+1]] == 0) {
                    right_map.erase(prefixSum[i+1]);
                }
                left_map[prefixSum[i+1]]++;
            }
        }

        return maxWays;
    }
};