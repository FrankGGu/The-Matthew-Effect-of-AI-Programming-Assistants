#include <iostream>
#include <vector>
#include <map>

using namespace std;

class Solution {
public:
    vector<int> earliestAndLatest(int n, int firstPlayer, int secondPlayer) {
        map<pair<int, int>, pair<int, int>> memo;

        function<pair<int, int>(int, int, int)> dfs = [&](int left, int right, int round) -> pair<int, int> {
            if (left == right) return {round, round};
            if (memo.find({left, right}) != memo.end()) {
                return memo[{left, right}];
            }

            int minRound = INT_MAX;
            int maxRound = INT_MIN;

            for (int i = 1; i <= n; ++i) {
                if (i == left || i == right) continue;

                int l = min(left, i);
                int r = max(left, i);

                if (l == firstPlayer && r == secondPlayer) {
                    minRound = min(minRound, round + 1);
                    maxRound = max(maxRound, round + 1);
                }

                if (l == secondPlayer && r == firstPlayer) {
                    minRound = min(minRound, round + 1);
                    maxRound = max(maxRound, round + 1);
                }

                auto [minR, maxR] = dfs(l, r, round + 1);
                minRound = min(minRound, minR);
                maxRound = max(maxRound, maxR);
            }

            memo[{left, right}] = {minRound, maxRound};
            return {minRound, maxRound};
        };

        return {dfs(1, n, 1).first, dfs(1, n, 1).second};
    }
};