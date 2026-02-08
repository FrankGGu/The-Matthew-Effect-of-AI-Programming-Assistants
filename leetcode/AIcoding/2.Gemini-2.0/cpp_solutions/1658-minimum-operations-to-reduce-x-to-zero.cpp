#include <vector>
#include <numeric>
#include <unordered_map>

using namespace std;

class Solution {
public:
    int minOperations(vector<int>& nums, int x) {
        int target = accumulate(nums.begin(), nums.end(), 0) - x;
        if (target == 0) return nums.size();
        unordered_map<int, int> prefixSum;
        prefixSum[0] = -1;
        int currentSum = 0;
        int maxLength = -1;
        for (int i = 0; i < nums.size(); ++i) {
            currentSum += nums[i];
            if (prefixSum.count(currentSum - target)) {
                maxLength = max(maxLength, i - prefixSum[currentSum - target]);
            }
            prefixSum[currentSum] = i;
        }

        if (maxLength == -1) return -1;
        return nums.size() - maxLength;
    }
};