class Solution {
public:
    int distinctEchoSubstrings(string text) {
        unordered_set<string> seen;
        int n = text.size();
        for (int len = 1; len <= n / 2; ++len) {
            for (int i = 0; i + 2 * len <= n; ++i) {
                string a = text.substr(i, len);
                string b = text.substr(i + len, len);
                if (a == b) {
                    seen.insert(a);
                }
            }
        }
        return seen.size();
    }
};