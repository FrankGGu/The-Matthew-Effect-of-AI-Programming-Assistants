#include <iostream>
#include <vector>
#include <cmath>

using namespace std;

class Solution {
public:
    int numDupDigitsInts(int n) {
        vector<int> digits;
        int temp = n;
        while (temp > 0) {
            digits.push_back(temp % 10);
            temp /= 10;
        }
        int m = digits.size();
        vector<int> dp(m, 0);
        vector<vector<int>> memo(m, vector<int>(10, -1));

        function<int(int, int, bool)> dfs = [&](int pos, int mask, bool tight) -> int {
            if (pos == m) return 0;
            if (memo[pos][mask] != -1) return memo[pos][mask];

            int limit = tight ? digits[pos] : 9;
            int res = 0;

            for (int d = 0; d <= limit; ++d) {
                bool new_tight = tight && (d == limit);
                int new_mask = mask;
                if ((mask & (1 << d)) != 0) {
                    res += dfs(pos + 1, new_mask, new_tight);
                } else {
                    new_mask |= (1 << d);
                    res += dfs(pos + 1, new_mask, new_tight);
                }
            }

            memo[pos][mask] = res;
            return res;
        };

        int total = 0;
        for (int i = 1; i < m; ++i) {
            total += 9 * pow(9, i - 1);
        }

        return total - dfs(0, 0, true);
    }
};