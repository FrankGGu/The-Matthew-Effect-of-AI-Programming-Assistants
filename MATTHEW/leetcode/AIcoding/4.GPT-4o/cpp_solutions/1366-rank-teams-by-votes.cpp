#include <vector>
#include <string>
#include <unordered_map>
#include <algorithm>

using namespace std;

class Solution {
public:
    string rankTeams(vector<string>& votes) {
        int n = votes.size();
        int m = votes[0].size();
        unordered_map<char, vector<int>> rank;

        for (const auto& vote : votes) {
            for (int i = 0; i < m; ++i) {
                rank[vote[i]].resize(m, 0);
                rank[vote[i]][i]++;
            }
        }

        vector<char> teams;
        for (const auto& pair : rank) {
            teams.push_back(pair.first);
        }

        sort(teams.begin(), teams.end(), [&](char a, char b) {
            for (int i = 0; i < m; ++i) {
                if (rank[a][i] != rank[b][i]) {
                    return rank[a][i] > rank[b][i];
                }
            }
            return a < b;
        });

        return string(teams.begin(), teams.end());
    }
};