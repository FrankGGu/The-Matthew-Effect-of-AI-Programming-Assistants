#include <iostream>
#include <vector>
#include <queue>

using namespace std;

class Solution {
public:
    bool isPossible(vector<int>& nums, int k) {
        int n = nums.size();
        vector<int> diff(n + 1, 0);
        int current = 0;

        for (int i = 0; i < n; ++i) {
            current += diff[i];
            if (nums[i] < current) return false;
            if (i + k < n) {
                diff[i + k] += nums[i] - current;
            }
            current = nums[i] - current;
        }

        return true;
    }
};