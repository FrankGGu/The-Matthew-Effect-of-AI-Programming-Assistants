class Solution {
public:
    int charactersAdded(string s, vector<vector<string>>& transformations) {
        unordered_map<string, string> mp;
        for (auto& t : transformations) {
            mp[t[0]] = t[1];
        }

        string current = s;
        bool changed;
        do {
            changed = false;
            string next;
            int i = 0;
            int n = current.size();
            while (i < n) {
                bool found = false;
                for (int len = 1; len <= 2 && i + len <= n; ++len) {
                    string sub = current.substr(i, len);
                    if (mp.count(sub)) {
                        next += mp[sub];
                        i += len;
                        found = true;
                        changed = true;
                        break;
                    }
                }
                if (!found) {
                    next += current[i];
                    ++i;
                }
            }
            current = next;
        } while (changed);

        return current.size() - s.size();
    }
};