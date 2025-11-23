#include <iostream>
#include <vector>

using namespace std;

class Solution {
public:
    bool isAdjacentIncreasing(const vector<int>& nums, int k) {
        for (int i = 0; i + k <= nums.size(); ++i) {
            bool flag = true;
            for (int j = 0; j < k - 1; ++j) {
                if (nums[i + j] >= nums[i + j + 1]) {
                    flag = false;
                    break;
                }
            }
            if (flag) return true;
        }
        return false;
    }
};