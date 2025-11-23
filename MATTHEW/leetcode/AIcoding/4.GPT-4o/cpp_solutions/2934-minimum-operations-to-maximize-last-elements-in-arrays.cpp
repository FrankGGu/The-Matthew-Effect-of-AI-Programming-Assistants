#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int minOperations(vector<int>& nums, int x) {
        int total = accumulate(nums.begin(), nums.end(), 0);
        int target = total - x;
        if (target < 0) return -1;

        int maxLength = -1, currentSum = 0;
        unordered_map<int, int> prefixSum;

        prefixSum[0] = -1; // Handle the case when the whole array is the answer
        for (int i = 0; i < nums.size(); ++i) {
            currentSum += nums[i];
            if (prefixSum.find(currentSum - target) != prefixSum.end()) {
                maxLength = max(maxLength, i - prefixSum[currentSum - target]);
            }
            prefixSum[currentSum] = i;
        }

        return maxLength == -1 ? -1 : nums.size() - maxLength;
    }
};