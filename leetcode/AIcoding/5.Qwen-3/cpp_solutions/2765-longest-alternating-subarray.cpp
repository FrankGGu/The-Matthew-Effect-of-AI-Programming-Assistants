#include <iostream>
#include <vector>

using namespace std;

class Solution {
public:
    int longestAlternatingSubarray(vector<int>& nums) {
        int n = nums.size();
        if (n == 0) return 0;
        int maxLen = 1;
        int currentLen = 1;

        for (int i = 1; i < n; ++i) {
            if ((nums[i] > nums[i - 1] && nums[i - 1] < nums[i - 2]) || 
                (nums[i] < nums[i - 1] && nums[i - 1] > nums[i - 2])) {
                currentLen++;
                maxLen = max(maxLen, currentLen);
            } else {
                currentLen = 1;
            }
        }

        return maxLen;
    }
};