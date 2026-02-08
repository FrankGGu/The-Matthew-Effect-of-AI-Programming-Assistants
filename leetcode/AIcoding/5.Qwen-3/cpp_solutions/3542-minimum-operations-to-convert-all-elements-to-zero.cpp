#include <iostream>
#include <vector>

using namespace std;

class Solution {
public:
    int minimumOperations(vector<int>& nums) {
        int operations = 0;
        while (true) {
            bool hasNonZero = false;
            for (int i = 0; i < nums.size(); ++i) {
                if (nums[i] != 0) {
                    hasNonZero = true;
                    break;
                }
            }
            if (!hasNonZero) break;
            int minVal = INT_MAX;
            for (int i = 0; i < nums.size(); ++i) {
                if (nums[i] != 0 && nums[i] < minVal) {
                    minVal = nums[i];
                }
            }
            for (int i = 0; i < nums.size(); ++i) {
                if (nums[i] != 0) {
                    nums[i] -= minVal;
                }
            }
            operations++;
        }
        return operations;
    }
};