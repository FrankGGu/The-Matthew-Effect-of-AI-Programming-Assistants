#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int maxSequenceValue(vector<int>& nums) {
        int n = nums.size();
        int maxVal = 0;
        for (int i = 0; i < n; ++i) {
            int current = 1;
            for (int j = i + 1; j < n; ++j) {
                if (nums[j] > nums[j - 1]) {
                    current++;
                } else {
                    break;
                }
            }
            maxVal = max(maxVal, current);
        }
        return maxVal;
    }
};