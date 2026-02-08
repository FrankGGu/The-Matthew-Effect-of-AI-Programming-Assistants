#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int maxLen(vector<int>& nums, int n) {
        int max_len = 0;
        int positive = 0, negative = 0;

        for (int i = 0; i < n; ++i) {
            if (nums[i] > 0) {
                positive++;
                negative++;
            } else if (nums[i] < 0) {
                int temp = positive;
                positive = negative + 1;
                negative = temp + 1;
            } else {
                positive = 0;
                negative = 0;
            }

            if (positive > max_len) {
                max_len = positive;
            }
        }

        return max_len;
    }

    int maxLongestSubarray(vector<int>& nums) {
        return maxLen(nums, nums.size());
    }
};