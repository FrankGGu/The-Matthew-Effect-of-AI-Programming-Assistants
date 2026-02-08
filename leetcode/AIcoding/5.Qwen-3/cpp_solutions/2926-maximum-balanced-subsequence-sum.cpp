#include <iostream>
#include <vector>
#include <algorithm>
#include <map>

using namespace std;

class Solution {
public:
    int maxBalancedSubsequenceSum(vector<int>& nums) {
        int n = nums.size();
        vector<pair<int, int>> arr(n);
        for (int i = 0; i < n; ++i) {
            arr[i] = {nums[i], i};
        }

        sort(arr.begin(), arr.end());

        map<int, int> dp;
        int result = INT_MIN;

        for (int i = 0; i < n; ++i) {
            int value = arr[i].first;
            int index = arr[i].second;

            auto it = dp.lower_bound(index);
            int max_prev = 0;
            if (it != dp.begin()) {
                --it;
                max_prev = it->second;
            }

            int current = value + max_prev;
            dp[index] = current;
            result = max(result, current);
        }

        return result;
    }
};