#include <iostream>
#include <vector>
#include <unordered_set>
#include <algorithm>

using namespace std;

class Solution {
public:
    int countBeautifulNumbers(int n) {
        vector<int> digits;
        while (n > 0) {
            digits.push_back(n % 10);
            n /= 10;
        }
        reverse(digits.begin(), digits.end());

        int result = 0;
        vector<bool> used(10, false);
        unordered_set<int> seen;

        function<void(int, int, int)> dfs = [&](int pos, int count, int mask) {
            if (pos == digits.size()) {
                if (count > 0) {
                    result++;
                }
                return;
            }

            for (int d = 0; d <= 9; ++d) {
                if (used[d]) continue;
                if (d == 0 && pos == 0) continue;

                int new_mask = mask;
                if ((mask & (1 << d)) == 0) {
                    new_mask |= (1 << d);
                }

                if (pos == 0 || d >= digits[pos]) {
                    used[d] = true;
                    dfs(pos + 1, count + (d % 2 == 0 ? 1 : 0), new_mask);
                    used[d] = false;
                } else {
                    break;
                }
            }
        };

        dfs(0, 0, 0);
        return result;
    }
};