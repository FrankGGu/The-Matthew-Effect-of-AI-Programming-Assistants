#include <iostream>
#include <vector>
#include <string>
#include <algorithm>
#include <cmath>

using namespace std;

class Solution {
public:
    int numberOfBeautifulIntegers(int k) {
        string s = to_string(k);
        int n = s.size();
        vector<vector<vector<int>>> dp(n + 1, vector<vector<int>>(2, vector<int>(2, -1)));
        vector<vector<vector<int>>> memo(n + 1, vector<vector<int>>(2, vector<int>(2, -1)));

        function<int(int, bool, bool)> dfs = [&](int pos, bool tight, bool leading_zero) -> int {
            if (pos == n) {
                return leading_zero ? 0 : 1;
            }
            if (memo[pos][tight][leading_zero] != -1) {
                return memo[pos][tight][leading_zero];
            }

            int limit = tight ? s[pos] - '0' : 9;
            int res = 0;

            for (int d = 0; d <= limit; ++d) {
                bool new_tight = tight && (d == limit);
                bool new_leading_zero = leading_zero && (d == 0);

                if (!new_leading_zero) {
                    int cnt = 0;
                    int temp = d;
                    while (temp > 0) {
                        temp /= 10;
                        ++cnt;
                    }
                    if (cnt % 2 == 0) {
                        res += dfs(pos + 1, new_tight, new_leading_zero);
                    }
                } else {
                    res += dfs(pos + 1, new_tight, new_leading_zero);
                }
            }

            memo[pos][tight][leading_zero] = res;
            return res;
        };

        return dfs(0, true, true);
    }
};