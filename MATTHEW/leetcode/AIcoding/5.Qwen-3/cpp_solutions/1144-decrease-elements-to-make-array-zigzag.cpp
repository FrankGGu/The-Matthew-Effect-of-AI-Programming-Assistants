#include <iostream>
#include <vector>

using namespace std;

class Solution {
public:
    int minMovesToMakeZigzag(const vector<int>& nums) {
        int n = nums.size();
        if (n <= 2) return 0;

        int res = 0;
        for (int i = 1; i < n - 1; i += 2) {
            int left = nums[i - 1];
            int right = nums[i + 1];
            if (nums[i] >= left || nums[i] >= right) {
                int move = max(left, right) - nums[i] + 1;
                res += move;
                nums[i] += move;
            }
        }

        for (int i = 0; i < n - 1; i += 2) {
            int left = nums[i - 1];
            int right = nums[i + 1];
            if (i == 0) left = 0;
            if (i == n - 1) right = 0;
            if (nums[i] >= left || nums[i] >= right) {
                int move = max(left, right) - nums[i] + 1;
                res += move;
                nums[i] += move;
            }
        }

        return res;
    }
};