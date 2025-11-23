#include <iostream>
#include <vector>
#include <cmath>
#include <climits>

using namespace std;

class Solution {
public:
    int closestToK(vector<int>& nums, int k) {
        int n = nums.size();
        int minDiff = INT_MAX;
        int result = 0;

        for (int i = 0; i < n; ++i) {
            int currentOr = 0;
            for (int j = i; j < n; ++j) {
                currentOr |= nums[j];
                int diff = abs(currentOr - k);
                if (diff < minDiff) {
                    minDiff = diff;
                    result = currentOr;
                }
                if (minDiff == 0) {
                    return result;
                }
            }
        }

        return result;
    }
};