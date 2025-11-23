#include <iostream>
#include <vector>

using namespace std;

class Solution {
public:
    int subsetXORSum(vector<int>& nums) {
        int n = nums.size();
        int total = 0;
        for (int mask = 0; mask < (1 << n); ++mask) {
            int xorVal = 0;
            for (int i = 0; i < n; ++i) {
                if (mask & (1 << i)) {
                    xorVal ^= nums[i];
                }
            }
            total += xorVal;
        }
        return total;
    }
};