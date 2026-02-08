class Solution {
public:
    long long distinctNames(vector<string>& ideas) {
        unordered_set<string> groups[26];
        for (const string& idea : ideas) {
            groups[idea[0] - 'a'].insert(idea.substr(1));
        }

        long long res = 0;
        for (int i = 0; i < 25; ++i) {
            for (int j = i + 1; j < 26; ++j) {
                int common = 0;
                for (const string& s : groups[i]) {
                    if (groups[j].count(s)) {
                        ++common;
                    }
                }
                res += 2LL * (groups[i].size() - common) * (groups[j].size() - common);
            }
        }
        return res;
    }
};