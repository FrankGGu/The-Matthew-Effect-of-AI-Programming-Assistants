#include <vector>

using namespace std;

class Solution {
public:
    vector<int> constructDistancedSequence(int n) {
        vector<int> res(2 * n - 1, 0);
        vector<bool> used(n + 1, false);

        function<bool(int)> solve = [&](int index) {
            if (index == 2 * n - 1) {
                return true;
            }

            if (res[index] != 0) {
                return solve(index + 1);
            }

            for (int num = n; num >= 1; --num) {
                if (!used[num]) {
                    if (num == 1) {
                        used[num] = true;
                        res[index] = num;
                        if (solve(index + 1)) {
                            return true;
                        }
                        res[index] = 0;
                        used[num] = false;
                    } else if (index + num < 2 * n - 1 && res[index + num] == 0) {
                        used[num] = true;
                        res[index] = num;
                        res[index + num] = num;
                        if (solve(index + 1)) {
                            return true;
                        }
                        res[index] = 0;
                        res[index + num] = 0;
                        used[num] = false;
                    }
                }
            }
            return false;
        };

        solve(0);
        return res;
    }
};