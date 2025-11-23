#include <vector>
#include <algorithm>

class Solution {
public:
    int maxJumps(std::vector<int>& arr, int d) {
        int n = arr.size();
        std::vector<int> memo(n, 0);
        int max_jumps = 0;
        for (int i = 0; i < n; ++i) {
            max_jumps = std::max(max_jumps, dfs(i, arr, d, memo));
        }
        return max_jumps;
    }

private:
    int dfs(int i, std::vector<int>& arr, int d, std::vector<int>& memo) {
        if (memo[i] != 0) {
            return memo[i];
        }

        int n = arr.size();
        int res = 1;

        for (int j = i + 1; j <= std::min(n - 1, i + d); ++j) {
            if (arr[j] >= arr[i]) {
                break;
            }
            res = std::max(res, 1 + dfs(j, arr, d, memo));
        }

        for (int j = i - 1; j >= std::max(0, i - d); --j) {
            if (arr[j] >= arr[i]) {
                break;
            }
            res = std::max(res, 1 + dfs(j, arr, d, memo));
        }

        memo[i] = res;
        return res;
    }
};