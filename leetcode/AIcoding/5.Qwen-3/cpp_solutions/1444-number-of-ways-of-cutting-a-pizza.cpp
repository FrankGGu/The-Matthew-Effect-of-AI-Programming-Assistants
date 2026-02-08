#include <vector>
#include <cmath>
#include <unordered_map>

using namespace std;

class Solution {
public:
    int ways(vector<string>& pizza, int k) {
        int m = pizza.size();
        int n = pizza[0].size();
        vector<vector<vector<int>>> dp(k, vector<vector<int>>(m, vector<int>(n, -1)));
        unordered_map<int, int> memo;

        function<int(int, int, int)> dfs = [&](int x, int y, int k) -> int {
            if (k == 0) return 1;
            int key = (x << 24) | (y << 16) | k;
            if (memo.find(key) != memo.end()) return memo[key];

            int res = 0;
            for (int i = x; i < m; ++i) {
                for (int j = y; j < n; ++j) {
                    if (pizza[i][j] == 'A') {
                        bool hasApple = false;
                        for (int a = i; a < m; ++a) {
                            for (int b = j; a < m && b < n; ++b) {
                                if (pizza[a][b] == 'A') {
                                    hasApple = true;
                                    break;
                                }
                            }
                            if (hasApple) break;
                        }
                        if (hasApple) {
                            res += dfs(i, j, k - 1);
                        }
                    }
                }
            }
            memo[key] = res;
            return res;
        };

        return dfs(0, 0, k - 1);
    }
};