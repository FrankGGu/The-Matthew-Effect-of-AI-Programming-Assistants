#include <iostream>
#include <vector>
#include <algorithm>
#include <cmath>

using namespace std;

class Solution {
public:
    vector<vector<int>> sortedGcdPairs(int n, vector<vector<int>>& queries) {
        vector<int> gcds;
        for (int i = 1; i <= n; ++i) {
            for (int j = i + 1; j <= n; ++j) {
                gcds.push_back(__gcd(i, j));
            }
        }
        sort(gcds.begin(), gcds.end());

        vector<vector<int>> result;
        for (const auto& q : queries) {
            int l = q[0], r = q[1];
            vector<int> res;
            for (int i = 0; i < gcds.size(); ++i) {
                if (l <= gcds[i] && gcds[i] <= r) {
                    res.push_back(gcds[i]);
                }
            }
            result.push_back(res);
        }
        return result;
    }
};