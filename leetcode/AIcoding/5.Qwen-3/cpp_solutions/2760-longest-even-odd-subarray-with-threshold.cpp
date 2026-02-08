#include <iostream>
#include <vector>

using namespace std;

class Solution {
public:
    int longestAlternatingSubarray(vector<int>& nums, int threshold) {
        int n = nums.size();
        int maxLen = 0;

        for (int i = 0; i < n; ++i) {
            if (nums[i] > threshold) continue;
            int len = 1;
            maxLen = max(maxLen, len);
            for (int j = i + 1; j < n; ++j) {
                if (nums[j] > threshold) break;
                if ((nums[j - 1] % 2 == 0 && nums[j] % 2 == 1) || (nums[j - 1] % 2 == 1 && nums[j] % 2 == 0)) {
                    len++;
                    maxLen = max(maxLen, len);
                } else {
                    break;
                }
            }
        }

        return maxLen;
    }
};