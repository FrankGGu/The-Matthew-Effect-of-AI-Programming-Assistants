#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int longestStrictlyMonotonicSubarray(vector<int>& nums) {
        int n = nums.size();
        if (n < 2) return n;

        int maxLength = 1;
        int currentLength = 1;

        for (int i = 1; i < n; ++i) {
            if (nums[i] > nums[i - 1]) {
                currentLength++;
                maxLength = max(maxLength, currentLength);
            } else if (nums[i] < nums[i - 1]) {
                currentLength = 1;
                maxLength = max(maxLength, currentLength);
            } else {
                currentLength = 1;
            }
        }

        currentLength = 1;
        for (int i = 1; i < n; ++i) {
            if (nums[i] < nums[i - 1]) {
                currentLength++;
                maxLength = max(maxLength, currentLength);
            } else if (nums[i] > nums[i - 1]) {
                currentLength = 1;
                maxLength = max(maxLength, currentLength);
            } else {
                currentLength = 1;
            }
        }

        return maxLength;
    }
};