#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int minOperations(vector<int>& nums) {
        int n = nums.size();
        vector<int> dp0(n, 0), dp1(n, 0);

        for (int i = 0; i < n; ++i) {
            if (nums[i] == 0) {
                dp0[i] = min(dp0[i - 1], dp1[i - 1]) + 1;
                dp1[i] = 0;
            } else {
                dp1[i] = min(dp0[i - 1], dp1[i - 1]) + 1;
                dp0[i] = 0;
            }
        }

        return min(dp0[n - 1], dp1[n - 1]);
    }
};