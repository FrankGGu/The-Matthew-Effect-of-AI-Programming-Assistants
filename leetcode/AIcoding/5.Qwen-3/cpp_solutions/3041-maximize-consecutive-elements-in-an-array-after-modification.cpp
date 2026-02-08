#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int maximizeConsecutiveElements(vector<int>& nums) {
        sort(nums.begin(), nums.end());
        int maxCount = 1;
        int count = 1;
        for (int i = 1; i < nums.size(); ++i) {
            if (nums[i] == nums[i - 1]) {
                continue;
            } else if (nums[i] == nums[i - 1] + 1) {
                count++;
                maxCount = max(maxCount, count);
            } else {
                count = 1;
            }
        }
        return maxCount;
    }
};