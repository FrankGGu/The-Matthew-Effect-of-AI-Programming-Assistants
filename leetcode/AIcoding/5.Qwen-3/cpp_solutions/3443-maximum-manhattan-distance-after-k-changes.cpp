#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int maxDistance(vector<int>& nums, int k) {
        int n = nums.size();
        vector<int> diff(n - 1);
        for (int i = 0; i < n - 1; ++i) {
            diff[i] = nums[i + 1] - nums[i];
        }

        sort(diff.begin(), diff.end());

        int res = 0;
        for (int i = 0; i < n - 1; ++i) {
            if (i < k) {
                res += diff[i];
            } else {
                res += diff[i];
            }
        }

        return res;
    }
};