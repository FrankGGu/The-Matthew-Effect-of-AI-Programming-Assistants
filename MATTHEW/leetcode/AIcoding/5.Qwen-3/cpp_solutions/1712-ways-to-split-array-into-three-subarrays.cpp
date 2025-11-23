#include <iostream>
#include <vector>

using namespace std;

class Solution {
public:
    int waysToSplitArray(vector<int>& nums) {
        int total = 0;
        for (int num : nums) {
            total += num;
        }

        int leftSum = 0;
        int count = 0;

        for (int i = 0; i < nums.size() - 1; ++i) {
            leftSum += nums[i];
            int rightSum = total - leftSum;
            if (rightSum >= leftSum) {
                ++count;
            }
        }

        return count;
    }
};