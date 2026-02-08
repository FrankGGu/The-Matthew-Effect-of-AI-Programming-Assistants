class Solution {
public:
    vector<vector<int>> substringXorQueries(string s, vector<vector<int>>& queries) {
        unordered_map<int, vector<int>> mp;
        int n = s.size();
        for (int i = 0; i < n; ++i) {
            if (s[i] == '0') {
                if (!mp.count(0)) {
                    mp[0] = {i, i};
                }
                continue;
            }
            int num = 0;
            for (int j = i; j < min(i + 30, n); ++j) {
                num = (num << 1) | (s[j] - '0');
                if (!mp.count(num)) {
                    mp[num] = {i, j};
                }
            }
        }
        vector<vector<int>> res;
        for (auto& q : queries) {
            int target = q[0] ^ q[1];
            if (mp.count(target)) {
                res.push_back(mp[target]);
            } else {
                res.push_back({-1, -1});
            }
        }
        return res;
    }
};