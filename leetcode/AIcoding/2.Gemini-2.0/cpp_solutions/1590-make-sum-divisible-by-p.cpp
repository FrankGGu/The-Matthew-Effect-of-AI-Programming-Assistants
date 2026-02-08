#include <numeric>
#include <unordered_map>

class Solution {
public:
    int minSubarray(vector<int>& nums, int p) {
        int n = nums.size();
        int target = 0;
        for (int num : nums) {
            target = (target + num) % p;
        }
        if (target == 0) {
            return 0;
        }
        unordered_map<int, int> prefixMap;
        prefixMap[0] = -1;
        int currentSum = 0;
        int minLength = n;
        for (int i = 0; i < n; i++) {
            currentSum = (currentSum + nums[i]) % p;
            int complement = (currentSum - target + p) % p;
            if (prefixMap.count(complement)) {
                minLength = min(minLength, i - prefixMap[complement]);
            }
            prefixMap[currentSum] = i;
        }
        return (minLength == n) ? -1 : minLength;
    }
};