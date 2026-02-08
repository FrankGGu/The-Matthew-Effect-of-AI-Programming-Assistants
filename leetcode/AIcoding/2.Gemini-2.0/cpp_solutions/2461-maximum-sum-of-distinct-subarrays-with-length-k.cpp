#include <vector>
#include <unordered_set>

using namespace std;

class Solution {
public:
    long long maximumSubarraySum(vector<int>& nums, int k) {
        long long maxSum = 0;
        long long currentSum = 0;
        unordered_set<int> seen;
        int n = nums.size();
        int left = 0;

        for (int right = 0; right < n; ++right) {
            while (seen.count(nums[right])) {
                seen.erase(nums[left]);
                currentSum -= nums[left];
                left++;
            }

            seen.insert(nums[right]);
            currentSum += nums[right];

            if (right - left + 1 == k) {
                if (seen.size() == k) {
                    maxSum = max(maxSum, currentSum);
                }
                seen.erase(nums[left]);
                currentSum -= nums[left];
                left++;
            }
        }

        return maxSum;
    }
};