#include <vector>

using namespace std;

class Solution {
public:
    int numberWays(vector<vector<int>>& hats) {
        int n = hats.size();
        vector<vector<int>> hatToPeople(41);
        for (int i = 0; i < n; ++i) {
            for (int hat : hats[i]) {
                hatToPeople[hat].push_back(i);
            }
        }

        vector<vector<int>> memo(41, vector<int>(1 << n, -1));
        int MOD = 1e9 + 7;

        function<int(int, int)> solve = [&](int hatId, int mask) {
            if (mask == (1 << n) - 1) {
                return 1;
            }
            if (hatId > 40) {
                return 0;
            }

            if (memo[hatId][mask] != -1) {
                return memo[hatId][mask];
            }

            int ans = solve(hatId + 1, mask) % MOD;

            for (int person : hatToPeople[hatId]) {
                if (!(mask & (1 << person))) {
                    ans = (ans + solve(hatId + 1, mask | (1 << person))) % MOD;
                }
            }

            return memo[hatId][mask] = ans % MOD;
        };

        return solve(1, 0);
    }
};