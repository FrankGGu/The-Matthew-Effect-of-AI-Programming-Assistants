#include <iostream>
#include <vector>
#include <unordered_map>

using namespace std;

class Solution {
public:
    int countGoodPartitions(vector<int>& nums) {
        unordered_map<int, int> lastIndices;
        for (int i = 0; i < nums.size(); ++i) {
            lastIndices[nums[i]] = i;
        }

        int result = 0;
        int prev = -1;
        for (int i = 0; i < nums.size(); ++i) {
            if (prev == -1 || i > prev) {
                prev = lastIndices[nums[i]];
                ++result;
            } else {
                prev = max(prev, lastIndices[nums[i]]);
            }
        }

        return result;
    }
};