#include <vector>
#include <map>
#include <climits>

using namespace std;

class Solution {
public:
    map<vector<int>, int> shortestSubsequences(vector<int>& big, vector<int>& small) {
        map<int, vector<int>> pos;
        for (int i = 0; i < big.size(); ++i) {
            pos[big[i]].push_back(i);
        }

        vector<int> dp(small.size(), -1);
        int len = INT_MAX;
        map<vector<int>, int> ans;

        function<int(int)> solve = [&](int i) {
            if (i == small.size()) return 0;
            if (dp[i] != -1) return dp[i];

            if (pos.find(small[i]) == pos.end()) return dp[i] = INT_MAX / 2;

            int best = INT_MAX / 2;
            for (int p : pos[small[i]]) {
                if (i == 0 || p > dp[i - 1]) {
                    dp[i] = p;
                    best = min(best, p + solve(i + 1));
                }
            }

            return dp[i] = best;
        };

        vector<int> first(small.size());
        for (int i = 0; i < small.size(); i++) {
            if (pos.find(small[i]) == pos.end()) return {};
            first[i] = pos[small[i]][0];
        }

        for (int i = 0; i < pos[small[0]].size(); i++) {
            int start = pos[small[0]][i];
            dp[0] = start;
            int end = solve(1);
            if (end == INT_MAX / 2) continue;

            vector<int> sub;
            sub.push_back(start);
            sub.push_back(end);

            if (end - start + 1 < len) {
                len = end - start + 1;
                ans.clear();
                ans[sub] = 1;
            } else if (end - start + 1 == len) {
                ans[sub]++;
            }
        }

        return ans;
    }
};