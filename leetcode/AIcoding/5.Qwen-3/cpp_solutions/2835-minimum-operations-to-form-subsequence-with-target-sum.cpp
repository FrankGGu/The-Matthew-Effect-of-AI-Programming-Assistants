#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int minOperations(vector<int>& nums, int target) {
        int operations = 0;
        int carry = 0;
        for (int i = 0; i < nums.size(); ++i) {
            int num = nums[i];
            int bit = (target >> i) & 1;
            if (bit == 1) {
                if (num > 0) {
                    --num;
                    ++carry;
                } else {
                    ++operations;
                    ++carry;
                }
            } else {
                if (num > 0) {
                    carry += num;
                }
            }
            carry >>= 1;
        }
        return operations;
    }
};