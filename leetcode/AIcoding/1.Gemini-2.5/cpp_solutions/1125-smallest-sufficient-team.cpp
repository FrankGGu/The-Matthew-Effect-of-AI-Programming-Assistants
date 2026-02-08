#include <iostream>
#include <vector>
#include <string>
#include <unordered_map>

using namespace std;

class Solution {
public:
    vector<int> smallestSufficientTeam(vector<string>& req_skills, vector<vector<string>>& people) {
        int n = req_skills.size();
        int m = people.size();

        unordered_map<string, int> skill_id;
        for (int i = 0; i < n; ++i) {
            skill_id[req_skills[i]] = i;
        }

        vector<int> skill_mask(m, 0);
        for (int i = 0; i < m; ++i) {
            for (const string& skill : people[i]) {
                if (skill_id.count(skill)) {
                    skill_mask[i] |= (1 << skill_id[skill]);
                }
            }
        }

        vector<vector<vector<int>>> dp(m + 1, vector<vector<int>>(1 << n, {}));
        dp[0][0] = {};

        for (int i = 1; i <= m; ++i) {
            for (int mask = 0; mask < (1 << n); ++mask) {
                dp[i][mask] = dp[i - 1][mask];

                int new_mask = mask | skill_mask[i - 1];
                vector<int> current_team = dp[i - 1][mask];
                if (current_team.empty() && mask != 0) continue;

                current_team.push_back(i - 1);
                if (dp[i][new_mask].empty() || current_team.size() < dp[i][new_mask].size()) {
                    dp[i][new_mask] = current_team;
                }
            }
        }

        return dp[m][(1 << n) - 1];
    }
};