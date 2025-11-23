#include <vector>
#include <algorithm>
#include <climits>
#include <map>

using namespace std;

class Solution {
public:
    int makeArrayIncreasing(vector<int>& arr1, vector<int>& arr2) {
        sort(arr2.begin(), arr2.end());
        arr2.erase(unique(arr2.begin(), arr2.end()), arr2.end());

        map<pair<int, int>, int> dp;
        dp[{-1, -1}] = 0;

        for (int num : arr1) {
            map<pair<int, int>, int> new_dp;
            for (auto& [key, cnt] : dp) {
                int prev = key.first;
                if (num > prev) {
                    auto new_key = make_pair(num, key.second);
                    if (new_dp.count(new_key) == 0 || new_dp[new_key] > cnt) {
                        new_dp[new_key] = cnt;
                    }
                }

                auto it = upper_bound(arr2.begin(), arr2.end(), key.second);
                if (it != arr2.end()) {
                    int val = *it;
                    if (val > prev) {
                        auto new_key = make_pair(val, val);
                        if (new_dp.count(new_key) == 0 || new_dp[new_key] > cnt + 1) {
                            new_dp[new_key] = cnt + 1;
                        }
                    }
                }
            }
            dp = new_dp;
            if (dp.empty()) return -1;
        }

        int res = INT_MAX;
        for (auto& [key, cnt] : dp) {
            res = min(res, cnt);
        }
        return res;
    }
};