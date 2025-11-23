#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int closestToTarget(int n, vector<int>& queries) {
        vector<int> dp;
        for (int i = 0; i < n; ++i) {
            vector<int> new_dp;
            for (int val : dp) {
                new_dp.push_back(val & i);
            }
            new_dp.push_back(i);
            dp = vector<int>(new_dp.begin(), unique(new_dp.begin(), new_dp.end()));
        }
        int min_diff = INT_MAX;
        for (int val : dp) {
            min_diff = min(min_diff, abs(val - queries[0]));
        }
        return min_diff;
    }
};