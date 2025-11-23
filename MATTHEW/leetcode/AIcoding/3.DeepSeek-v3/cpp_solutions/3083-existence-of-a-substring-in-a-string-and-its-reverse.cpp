class Solution {
public:
    bool isSubstringPresent(string s) {
        unordered_set<string> seen;
        for (int i = 0; i < s.size() - 1; ++i) {
            string sub = s.substr(i, 2);
            seen.insert(sub);
        }
        string rev = s;
        reverse(rev.begin(), rev.end());
        for (int i = 0; i < rev.size() - 1; ++i) {
            string sub = rev.substr(i, 2);
            if (seen.find(sub) != seen.end()) {
                return true;
            }
        }
        return false;
    }
};