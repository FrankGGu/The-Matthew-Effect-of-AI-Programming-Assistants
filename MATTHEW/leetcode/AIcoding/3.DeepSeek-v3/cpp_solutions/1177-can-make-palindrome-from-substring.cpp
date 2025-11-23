class Solution {
public:
    vector<bool> canMakePaliQueries(string s, vector<vector<int>>& queries) {
        int n = s.size();
        vector<vector<int>> prefix(n + 1, vector<int>(26, 0));
        for (int i = 0; i < n; ++i) {
            prefix[i + 1] = prefix[i];
            prefix[i + 1][s[i] - 'a']++;
        }
        vector<bool> res;
        for (auto& q : queries) {
            int l = q[0], r = q[1], k = q[2];
            int odd = 0;
            for (int i = 0; i < 26; ++i) {
                int cnt = prefix[r + 1][i] - prefix[l][i];
                if (cnt % 2 == 1) {
                    odd++;
                }
            }
            res.push_back(odd / 2 <= k);
        }
        return res;
    }
};