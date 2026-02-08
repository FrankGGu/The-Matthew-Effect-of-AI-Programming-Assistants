#include <vector>
#include <numeric>

class Solution {
public:
    std::vector<int> constructDistancedSequence(int n) {
        std::vector<int> result(2 * n - 1, 0);
        std::vector<bool> used(n + 1, false);
        solve(0, n, result, used);
        return result;
    }

private:
    bool solve(int index, int n, std::vector<int>& result, std::vector<bool>& used) {
        if (index == result.size()) {
            return true;
        }

        if (result[index] != 0) {
            return solve(index + 1, n, result, used);
        }

        for (int i = n; i >= 1; --i) {
            if (used[i]) {
                continue;
            }

            if (i == 1) {
                result[index] = 1;
                used[i] = true;
                if (solve(index + 1, n, result, used)) {
                    return true;
                }
                used[i] = false;
                result[index] = 0;
            } else {
                if (index + i < result.size() && result[index + i] == 0) {
                    result[index] = i;
                    result[index + i] = i;
                    used[i] = true;
                    if (solve(index + 1, n, result, used)) {
                        return true;
                    }
                    used[i] = false;
                    result[index] = 0;
                    result[index + i] = 0;
                }
            }
        }

        return false;
    }
};