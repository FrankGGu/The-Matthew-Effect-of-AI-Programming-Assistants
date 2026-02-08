#include <vector>
#include <algorithm>
#include <map>

using namespace std;

class Solution {
public:
    int makeArrayIncreasing(vector<int>& arr1, vector<int>& arr2) {
        sort(arr2.begin(), arr2.end());
        arr2.erase(unique(arr2.begin(), arr2.end()), arr2.end());

        map<pair<int, int>, int> dp;

        function<int(int, int)> solve = [&](int i, int prev) {
            if (i == arr1.size()) {
                return 0;
            }

            if (dp.count({i, prev})) {
                return dp[{i, prev}];
            }

            int res = INT_MAX;

            if (arr1[i] > prev) {
                res = solve(i + 1, arr1[i]);
            }

            auto it = upper_bound(arr2.begin(), arr2.end(), prev);
            if (it != arr2.end()) {
                int nextVal = *it;
                int subResult = solve(i + 1, nextVal);
                if (subResult != INT_MAX) {
                    res = min(res, 1 + subResult);
                }
            }

            return dp[{i, prev}] = res;
        };

        int result = solve(0, -1);
        return (result == INT_MAX) ? -1 : result;
    }
};