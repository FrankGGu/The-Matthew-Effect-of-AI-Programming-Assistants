#include <vector>
#include <string>
#include <unordered_map>
#include <algorithm>

using namespace std;

class Solution {
public:
    vector<int> smallestSufficientTeam(vector<string>& req_skills, vector<vector<string>>& people) {
        int n = req_skills.size();
        int m = people.size();

        unordered_map<string, int> skill_index;
        for (int i = 0; i < n; ++i) {
            skill_index[req_skills[i]] = i;
        }

        vector<int> skill_mask(m, 0);
        for (int i = 0; i < m; ++i) {
            for (const string& skill : people[i]) {
                if (skill_index.count(skill)) {
                    skill_mask[i] |= (1 << skill_index[skill]);
                }
            }
        }

        vector<vector<vector<int>>> dp(m + 1, vector<vector<int>>(1 << n));

        for (int i = 0; i <= m; ++i) {
            for (int j = 0; j < (1 << n); ++j) {
                dp[i][j] = vector<int>(m + 1, -1); 
            }
        }

        dp[0][0] = {};

        for (int i = 1; i <= m; ++i) {
            for (int mask = 0; mask < (1 << n); ++mask) {

                dp[i][mask] = dp[i-1][mask];

                int new_mask = mask | skill_mask[i-1];

                if(dp[i-1][mask].empty() && mask != 0) continue;

                vector<int> team;
                if(dp[i-1][mask].empty() && mask == 0){
                    team = {i-1};
                } else {
                    team = dp[i-1][mask];
                    team.push_back(i-1);
                }

                if (dp[i-1][new_mask].empty() || team.size() < dp[i-1][new_mask].size()) {
                   dp[i][new_mask] = team;
                } else {
                   dp[i][new_mask] = dp[i-1][new_mask];
                }
            }
        }

        return dp[m][(1 << n) - 1];
    }
};