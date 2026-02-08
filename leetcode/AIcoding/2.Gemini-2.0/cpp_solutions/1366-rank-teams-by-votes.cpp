#include <vector>
#include <string>
#include <algorithm>
#include <unordered_map>

using namespace std;

class Solution {
public:
    string rankTeams(vector<string>& votes) {
        int n = votes[0].size();
        unordered_map<char, vector<int>> rank;
        for (char c : votes[0]) {
            rank[c] = vector<int>(n, 0);
        }

        for (string vote : votes) {
            for (int i = 0; i < n; ++i) {
                rank[vote[i]][i]++;
            }
        }

        string teams = votes[0];
        sort(teams.begin(), teams.end(), [&](char a, char b) {
            for (int i = 0; i < n; ++i) {
                if (rank[a][i] != rank[b][i]) {
                    return rank[a][i] > rank[b][i];
                }
            }
            return a < b;
        });

        return teams;
    }
};