#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int maxElementAfterOperations(vector<int>& nums) {
        int n = nums.size();
        if (n == 0) return 0;
        sort(nums.begin(), nums.end());
        for (int i = n - 2; i >= 0; --i) {
            if (nums[i] < nums[i + 1]) {
                nums[i] = nums[i] + nums[i + 1];
            }
        }
        return nums[0];
    }
};