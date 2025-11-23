#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int partitionDisjoint(vector<int>& nums) {
        int n = nums.size();
        int leftMax = nums[0];
        int overallMax = nums[0];
        int partitionIndex = 0;

        for (int i = 1; i < n; ++i) {
            if (nums[i] < leftMax) {
                partitionIndex = i;
                leftMax = overallMax;
            } else {
                overallMax = max(overallMax, nums[i]);
            }
        }

        return partitionIndex + 1;
    }
};