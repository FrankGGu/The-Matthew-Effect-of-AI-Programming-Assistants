#include <iostream>
#include <vector>
#include <climits>
#include <algorithm>

using namespace std;

class Solution {
public:
    int maximumStrongPairXOR(vector<int>& nums) {
        int maxVal = 0;
        for (int i = 0; i < nums.size(); ++i) {
            for (int j = i + 1; j < nums.size(); ++j) {
                if (abs(nums[i] - nums[j]) <= min(nums[i], nums[j])) {
                    maxVal = max(maxVal, nums[i] ^ nums[j]);
                }
            }
        }
        return maxVal;
    }
};