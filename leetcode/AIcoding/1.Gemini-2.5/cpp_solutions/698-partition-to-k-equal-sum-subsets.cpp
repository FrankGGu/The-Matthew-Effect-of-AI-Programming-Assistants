#include <vector>
#include <numeric>
#include <algorithm> // For std::sort

class Solution {
public:
    bool canPartitionKSubsets(std::vector<int>& nums, int k) {
        int totalSum = std::accumulate(nums.begin(), nums.end(), 0);

        if (totalSum % k != 0) {
            return false;
        }

        int targetSum = totalSum / k;

        std::sort(nums.rbegin(), nums.rend());

        if (nums[0] > targetSum) {
            return false;
        }

        std::vector<int> buckets(k, 0);

        return backtrack(nums, targetSum, 0, buckets);
    }

private:
    bool backtrack(std::vector<int>& nums, int targetSum, int index, std::vector<int>& buckets) {
        if (index == nums.size()) {
            return true;
        }

        for (int i = 0; i < buckets.size(); ++i) {
            if (buckets[i] + nums[index] <= targetSum) {
                buckets[i] += nums[index];

                if (backtrack(nums, targetSum, index + 1, buckets)) {
                    return true;
                }

                buckets[i] -= nums[index];
            }

            if (buckets[i] == 0) { 
                break; 
            }
        }

        return false;
    }
};