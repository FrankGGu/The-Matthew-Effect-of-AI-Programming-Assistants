#include <iostream>
#include <vector>

using namespace std;

class Solution {
public:
    bool isGood(vector<int>& nums) {
        int n = nums.size();
        for (int i = 0; i < n; ++i) {
            if (nums[i] != i + 1) {
                return false;
            }
        }
        return true;
    }
};