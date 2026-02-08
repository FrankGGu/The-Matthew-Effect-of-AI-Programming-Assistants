#include <vector>
#include <unordered_set>

using namespace std;

class Solution {
public:
    int maximumUniqueSubarray(vector<int>& nums) {
        int n = nums.size();
        int left = 0;
        int right = 0;
        int currentSum = 0;
        int maxSum = 0;
        unordered_set<int> seen;

        while (right < n) {
            while (seen.count(nums[right])) {
                seen.erase(nums[left]);
                currentSum -= nums[left];
                left++;
            }

            seen.insert(nums[right]);
            currentSum += nums[right];
            maxSum = max(maxSum, currentSum);
            right++;
        }

        return maxSum;
    }
};