#include <iostream>
#include <vector>

using namespace std;

class Solution {
public:
    int countNonDecreasingSubarrays(vector<int>& nums, int k) {
        int n = nums.size();
        int result = 0;
        for (int i = 0; i < n; ++i) {
            int j = i;
            while (j < n && (j == i || nums[j] >= nums[j - 1])) {
                ++j;
            }
            int len = j - i;
            result += len * (len + 1) / 2;
            i = j - 1;
        }
        return result;
    }
};