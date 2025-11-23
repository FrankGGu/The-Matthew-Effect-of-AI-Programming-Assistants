class Solution {
public:
    vector<int> smallestSufficientTeam(vector<string>& req_skills, vector<vector<string>>& people) {
        int n = req_skills.size();
        unordered_map<string, int> skill_to_bit;
        for (int i = 0; i < n; ++i) {
            skill_to_bit[req_skills[i]] = i;
        }

        int m = people.size();
        vector<int> people_skills(m);
        for (int i = 0; i < m; ++i) {
            int mask = 0;
            for (const string& skill : people[i]) {
                mask |= (1 << skill_to_bit[skill]);
            }
            people_skills[i] = mask;
        }

        int target = (1 << n) - 1;
        unordered_map<int, vector<int>> dp;
        dp[0] = {};

        for (int i = 0; i < m; ++i) {
            unordered_map<int, vector<int>> new_dp = dp;
            for (auto& entry : dp) {
                int mask = entry.first;
                const vector<int>& team = entry.second;
                int new_mask = mask | people_skills[i];
                if (new_dp.find(new_mask) == new_dp.end() || team.size() + 1 < new_dp[new_mask].size()) {
                    new_dp[new_mask] = team;
                    new_dp[new_mask].push_back(i);
                }
            }
            dp = move(new_dp);
        }

        return dp[target];
    }
};