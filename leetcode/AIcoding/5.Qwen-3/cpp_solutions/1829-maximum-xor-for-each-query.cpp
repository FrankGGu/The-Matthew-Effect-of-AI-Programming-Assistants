#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    vector<int> getMaximumXor(vector<int>& nums, int maximumBit) {
        int n = nums.size();
        vector<int> result(n);
        int maxVal = (1 << maximumBit) - 1;
        int xorSum = 0;

        for (int i = 0; i < n; ++i) {
            xorSum ^= nums[i];
            result[n - 1 - i] = xorSum ^ maxVal;
        }

        return result;
    }
};