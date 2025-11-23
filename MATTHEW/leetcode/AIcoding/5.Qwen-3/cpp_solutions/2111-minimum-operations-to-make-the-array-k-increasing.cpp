#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int minOperations(const vector<int>& nums, int k) {
        int n = nums.size();
        int res = 0;
        for (int i = 0; i < k; ++i) {
            vector<int> sub;
            for (int j = i; j < n; j += k) {
                sub.push_back(nums[j]);
            }
            int len = sub.size();
            vector<int> dp;
            for (int num : sub) {
                auto it = lower_bound(dp.begin(), dp.end(), num);
                if (it == dp.end()) {
                    dp.push_back(num);
                } else {
                    *it = num;
                }
            }
            res += len - dp.size();
        }
        return res;
    }
};