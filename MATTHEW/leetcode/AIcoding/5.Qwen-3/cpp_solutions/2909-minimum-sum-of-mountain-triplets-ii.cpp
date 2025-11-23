#include <iostream>
#include <vector>
#include <climits>

using namespace std;

class Solution {
public:
    int minSumOfMountainTriplet(vector<int>& nums) {
        int n = nums.size();
        vector<int> leftMin(n, INT_MAX);
        vector<int> rightMin(n, INT_MIN);

        for (int i = 1; i < n; ++i) {
            leftMin[i] = min(leftMin[i - 1], nums[i - 1]);
        }

        for (int i = n - 2; i >= 0; --i) {
            rightMin[i] = max(rightMin[i + 1], nums[i + 1]);
        }

        for (int i = 1; i < n - 1; ++i) {
            if (leftMin[i] < nums[i] && nums[i] > rightMin[i]) {
                return leftMin[i] + nums[i] + rightMin[i];
            }
        }

        return -1;
    }
};