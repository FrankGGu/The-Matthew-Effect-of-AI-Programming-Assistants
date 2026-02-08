#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int minZeroArray(int n, vector<int>& nums, vector<vector<int>>& queries) {
        vector<int> diff(n + 1, 0);
        for (int i = 0; i < n; ++i) {
            diff[i] += nums[i];
            if (i + 1 < n) diff[i + 1] -= nums[i];
        }

        int res = 0;
        for (int i = 0; i < n; ++i) {
            if (diff[i] > 0) {
                res += diff[i];
                if (i + 1 < n) diff[i + 1] += diff[i];
            }
        }

        return res;
    }
};