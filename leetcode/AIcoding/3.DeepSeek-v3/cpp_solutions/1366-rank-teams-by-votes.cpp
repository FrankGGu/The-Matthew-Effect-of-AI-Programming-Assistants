class Solution {
public:
    string rankTeams(vector<string>& votes) {
        if (votes.empty()) return "";
        int n = votes[0].size();
        vector<vector<int>> count(26, vector<int>(n, 0));
        for (const string& vote : votes) {
            for (int i = 0; i < n; ++i) {
                count[vote[i] - 'A'][i]++;
            }
        }
        string res = votes[0];
        sort(res.begin(), res.end(), [&](char a, char b) {
            for (int i = 0; i < n; ++i) {
                if (count[a - 'A'][i] != count[b - 'A'][i]) {
                    return count[a - 'A'][i] > count[b - 'A'][i];
                }
            }
            return a < b;
        });
        return res;
    }
};