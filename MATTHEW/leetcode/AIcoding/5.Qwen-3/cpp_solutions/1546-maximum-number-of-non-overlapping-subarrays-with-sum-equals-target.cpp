#include <iostream>
#include <vector>
#include <unordered_map>

using namespace std;

class Solution {
public:
    int maxNumberNonOverlapping(vector<int>& nums, int target) {
        unordered_map<int, int> prefixSum;
        prefixSum[0] = -1;
        int currentSum = 0;
        int count = 0;
        for (int i = 0; i < nums.size(); ++i) {
            currentSum += nums[i];
            if (prefixSum.find(currentSum - target) != prefixSum.end()) {
                ++count;
                prefixSum.clear();
                prefixSum[0] = i;
                currentSum = 0;
            } else {
                prefixSum[currentSum] = i;
            }
        }
        return count;
    }
};