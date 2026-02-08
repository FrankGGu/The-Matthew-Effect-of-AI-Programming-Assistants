#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    vector<int> constructDistancedSequence(int n) {
        vector<int> ans(2 * n - 1, 0);
        vector<bool> used(n + 1, false);

        function<bool(int)> solve = [&](int index) {
            if (index == 2 * n - 1) {
                return true;
            }

            if (ans[index] != 0) {
                return solve(index + 1);
            }

            for (int num = n; num >= 1; --num) {
                if (!used[num]) {
                    if (num == 1) {
                        ans[index] = num;
                        used[num] = true;
                        if (solve(index + 1)) {
                            return true;
                        }
                        used[num] = false;
                        ans[index] = 0;
                    } else if (index + num < 2 * n - 1 && ans[index + num] == 0) {
                        ans[index] = num;
                        ans[index + num] = num;
                        used[num] = true;
                        if (solve(index + 1)) {
                            return true;
                        }
                        used[num] = false;
                        ans[index] = 0;
                        ans[index + num] = 0;
                    }
                }
            }
            return false;
        };

        solve(0);
        return ans;
    }
};