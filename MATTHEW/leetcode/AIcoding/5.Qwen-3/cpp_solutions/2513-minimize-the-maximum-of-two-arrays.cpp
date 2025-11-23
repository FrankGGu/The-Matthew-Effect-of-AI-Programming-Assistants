#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int minimizeMax(vector<int>& nums, int maximumBit) {
        int n = nums.size();
        vector<int> prefix(n + 1, 0);
        for (int i = 0; i < n; ++i) {
            prefix[i + 1] = prefix[i] ^ nums[i];
        }
        int maxVal = (1 << maximumBit) - 1;
        int result = 0;
        for (int i = 0; i < n; ++i) {
            int current = prefix[i + 1];
            for (int j = i + 1; j <= n; ++j) {
                int xorVal = prefix[j] ^ current;
                if (xorVal > result) {
                    result = xorVal;
                }
            }
        }
        return result;
    }
};