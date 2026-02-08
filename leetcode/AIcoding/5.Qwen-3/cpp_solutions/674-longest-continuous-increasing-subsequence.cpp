#include <iostream>
#include <vector>

using namespace std;

class Solution {
public:
    int lengthOfLongestIncreasingSubsequence(vector<int>& nums) {
        if (nums.empty()) return 0;
        int maxLen = 1;
        int currentLen = 1;
        for (int i = 1; i < nums.size(); ++i) {
            if (nums[i] > nums[i - 1]) {
                currentLen++;
                maxLen = max(maxLen, currentLen);
            } else {
                currentLen = 1;
            }
        }
        return maxLen;
    }
};