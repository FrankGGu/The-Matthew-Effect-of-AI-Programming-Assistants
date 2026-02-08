#include <iostream>
#include <vector>
#include <unordered_map>

using namespace std;

class Solution {
public:
    int findLengthOfLCIS(vector<int>& nums) {
        int maxLen = 0, currentLen = 0;
        for (int i = 0; i < nums.size(); ++i) {
            if (i == 0 || nums[i] > nums[i - 1]) {
                ++currentLen;
                maxLen = max(maxLen, currentLen);
            } else {
                currentLen = 1;
            }
        }
        return maxLen;
    }
};