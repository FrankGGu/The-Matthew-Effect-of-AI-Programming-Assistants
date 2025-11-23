#include <iostream>
#include <vector>
#include <unordered_map>

using namespace std;

class Solution {
public:
    bool hasContinuousSubarraySum(vector<int>& nums, int k) {
        if (nums.empty()) return false;
        unordered_map<int, int> prefixMod;
        prefixMod[0] = -1;
        int currentSum = 0;
        for (int i = 0; i < nums.size(); ++i) {
            currentSum += nums[i];
            if (k != 0) {
                currentSum %= k;
            }
            if (prefixMod.find(currentSum) != prefixMod.end()) {
                if (i - prefixMod[currentSum] > 1) {
                    return true;
                }
            } else {
                prefixMod[currentSum] = i;
            }
        }
        return false;
    }
};