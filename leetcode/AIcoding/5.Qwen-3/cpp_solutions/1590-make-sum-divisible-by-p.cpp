#include <iostream>
#include <vector>
#include <unordered_map>

using namespace std;

class Solution {
public:
    int minSubarray(vector<int>& nums, int p) {
        int n = nums.size();
        int total = 0;
        for (int num : nums) {
            total = (total + num) % p;
        }
        if (total == 0) return 0;

        unordered_map<int, int> prefixMap;
        prefixMap[0] = -1;
        int current = 0;
        int result = n;

        for (int i = 0; i < n; ++i) {
            current = (current + nums[i]) % p;
            int target = (current - total + p) % p;
            if (prefixMap.find(target) != prefixMap.end()) {
                result = min(result, i - prefixMap[target]);
            }
            prefixMap[current] = i;
        }

        return result == n ? -1 : result;
    }
};