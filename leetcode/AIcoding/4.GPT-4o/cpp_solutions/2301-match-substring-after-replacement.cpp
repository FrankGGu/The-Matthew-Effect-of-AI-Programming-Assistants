class Solution {
public:
    bool matchReplacement(string s, string sub, vector<vector<char>>& mappings) {
        unordered_map<char, unordered_set<char>> map;
        for (const auto& m : mappings) {
            map[m[0]].insert(m[1]);
        }

        int sLen = s.length();
        int subLen = sub.length();

        for (int i = 0; i <= sLen - subLen; ++i) {
            bool match = true;
            for (int j = 0; j < subLen; ++j) {
                if (s[i + j] != sub[j] && !map[sub[j]].count(s[i + j]) && s[i + j] != sub[j]) {
                    match = false;
                    break;
                }
            }
            if (match) return true;
        }
        return false;
    }
};