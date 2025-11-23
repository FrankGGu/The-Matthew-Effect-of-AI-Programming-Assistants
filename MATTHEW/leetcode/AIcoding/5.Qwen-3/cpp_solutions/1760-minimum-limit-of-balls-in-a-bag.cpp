#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int maxOperations(int n, vector<int>& nums, vector<int>& space) {
        sort(nums.begin(), nums.end());
        int operations = 0;
        int prev = -1;
        for (int i = 0; i < n; ++i) {
            if (prev == -1 || nums[i] - prev > space[i]) {
                operations++;
                prev = nums[i];
            }
        }
        return operations;
    }
};