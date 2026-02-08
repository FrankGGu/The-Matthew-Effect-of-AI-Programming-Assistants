#include <iostream>
#include <vector>

using namespace std;

class Solution {
public:
    bool isSplitPossible(const vector<int>& nums) {
        int sum = 0;
        for (int num : nums) {
            sum += num;
        }
        int leftSum = 0;
        for (int i = 0; i < nums.size() - 1; ++i) {
            leftSum += nums[i];
            if (leftSum == sum - leftSum) {
                return true;
            }
        }
        return false;
    }
};