class Solution {
public:
    bool matchReplacement(string s, string sub, vector<vector<char>>& mappings) {
        unordered_map<char, unordered_set<char>> mp;
        for (auto& mapping : mappings) {
            mp[mapping[0]].insert(mapping[1]);
        }

        int n = s.size();
        int m = sub.size();

        for (int i = 0; i <= n - m; ++i) {
            bool valid = true;
            for (int j = 0; j < m; ++j) {
                char s_char = s[i + j];
                char sub_char = sub[j];
                if (s_char != sub_char && (mp.find(sub_char) == mp.end() || mp[sub_char].find(s_char) == mp[sub_char].end())) {
                    valid = false;
                    break;
                }
            }
            if (valid) {
                return true;
            }
        }
        return false;
    }
};