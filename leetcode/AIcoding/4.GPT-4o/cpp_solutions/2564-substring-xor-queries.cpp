class Solution {
public:
    vector<int> substringXorQueries(string s, vector<vector<int>>& queries) {
        int n = s.size();
        unordered_map<int, vector<int>> mp;
        vector<int> result(queries.size(), -1);

        for (int i = 0; i < n; ++i) {
            int xorVal = 0;
            for (int j = i; j < n; ++j) {
                xorVal ^= (s[j] - '0');
                if (mp.find(xorVal) == mp.end()) {
                    mp[xorVal] = {i, j};
                }
            }
        }

        for (int i = 0; i < queries.size(); ++i) {
            int q = queries[i][0];
            if (mp.find(q) != mp.end()) {
                result[i] = mp[q][0];
            }
        }

        return result;
    }
};