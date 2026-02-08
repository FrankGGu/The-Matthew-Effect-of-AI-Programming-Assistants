#include <iostream>
#include <vector>

using namespace std;

class Solution {
public:
    int partitionDisjoint(vector<int>& nums) {
        int n = nums.size();
        vector<int> leftMax(n, 0);
        leftMax[0] = nums[0];
        for (int i = 1; i < n; ++i) {
            leftMax[i] = max(leftMax[i - 1], nums[i]);
        }

        int rightMin = nums[n - 1];
        for (int i = n - 2; i >= 0; --i) {
            if (leftMax[i] <= rightMin) {
                return i + 1;
            }
            rightMin = min(rightMin, nums[i]);
        }
        return 0;
    }
};