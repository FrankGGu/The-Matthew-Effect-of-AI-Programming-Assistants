#include <vector>
#include <string>
#include <unordered_map>
#include <algorithm>

using namespace std;

class Solution {
public:
    vector<int> smallestSufficientTeam(vector<string>& reqSkills, vector<vector<string>>& people) {
        int n = reqSkills.size();
        unordered_map<string, int> skillIndex;
        for (int i = 0; i < n; ++i) {
            skillIndex[reqSkills[i]] = i;
        }

        int m = people.size();
        vector<int> personSkills(m);
        for (int i = 0; i < m; ++i) {
            for (const string& skill : people[i]) {
                personSkills[i] |= (1 << skillIndex[skill]);
            }
        }

        unordered_map<int, vector<int>> dp;
        dp[0] = {};

        for (int i = 0; i < m; ++i) {
            unordered_map<int, vector<int>> newDp = dp;
            for (const auto& [mask, team] : dp) {
                int newMask = mask | personSkills[i];
                if (newDp.find(newMask) == newDp.end() || newDp[newMask].size() > team.size() + 1) {
                    newDp[newMask] = team;
                    newDp[newMask].push_back(i);
                }
            }
            dp = move(newDp);
        }

        return dp[(1 << n) - 1];
    }
};