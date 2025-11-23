#include <iostream>
#include <vector>

using namespace std;

class Solution {
public:
    int minOperations(vector<int>& nums) {
        int n = nums.size();
        int operations = 0;
        int flip = 0;

        for (int i = 0; i < n; ++i) {
            if (nums[i] ^ flip) {
                operations++;
                flip ^= 1;
            }
        }

        return operations;
    }
};