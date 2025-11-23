#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    long long minimumSum(vector<int>& nums) {
        int n = nums.size();
        vector<int> left(n), right(n);
        left[0] = nums[0];
        for (int i = 1; i < n; ++i) {
            left[i] = min(left[i - 1], nums[i]);
        }
        right[n - 1] = nums[n - 1];
        for (int i = n - 2; i >= 0; --i) {
            right[i] = min(right[i + 1], nums[i]);
        }
        long long ans = LLONG_MAX;
        for (int i = 1; i < n - 1; ++i) {
            if (nums[i] > left[i - 1] || nums[i] > right[i + 1]) continue;
            ans = min(ans, (long long)nums[i] + left[i - 1] + right[i + 1]);
        }
        return ans;
    }
};