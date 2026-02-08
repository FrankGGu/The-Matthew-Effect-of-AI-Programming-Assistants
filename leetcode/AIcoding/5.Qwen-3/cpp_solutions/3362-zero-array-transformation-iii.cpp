#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    bool isZeroArray(vector<int>& nums, vector<vector<int>>& queries) {
        int n = nums.size();
        vector<long long> diff(n + 1, 0);

        for (const auto& q : queries) {
            int l = q[0], r = q[1];
            diff[l]++;
            if (r + 1 < n) diff[r + 1]--;
        }

        long long cnt = 0;
        for (int i = 0; i < n; ++i) {
            cnt += diff[i];
            if (nums[i] - cnt > 0) return false;
        }

        return true;
    }
};