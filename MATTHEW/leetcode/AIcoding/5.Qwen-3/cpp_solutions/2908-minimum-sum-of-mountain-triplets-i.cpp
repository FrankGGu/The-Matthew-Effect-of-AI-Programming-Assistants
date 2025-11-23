#include <iostream>
#include <vector>
#include <climits>

using namespace std;

class Solution {
public:
    int minSumOfMountainTriplet(vector<int>& nums) {
        int n = nums.size();
        int minSum = INT_MAX;
        for (int i = 1; i < n - 1; ++i) {
            bool left = false;
            bool right = false;
            for (int j = 0; j < i; ++j) {
                if (nums[j] < nums[i]) {
                    left = true;
                    break;
                }
            }
            for (int k = i + 1; k < n; ++k) {
                if (nums[k] < nums[i]) {
                    right = true;
                    break;
                }
            }
            if (left && right) {
                for (int j = 0; j < i; ++j) {
                    for (int k = i + 1; k < n; ++k) {
                        if (nums[j] < nums[i] && nums[k] < nums[i]) {
                            minSum = min(minSum, nums[j] + nums[i] + nums[k]);
                            break;
                        }
                    }
                    if (minSum != INT_MAX) break;
                }
            }
        }
        return minSum == INT_MAX ? -1 : minSum;
    }
};