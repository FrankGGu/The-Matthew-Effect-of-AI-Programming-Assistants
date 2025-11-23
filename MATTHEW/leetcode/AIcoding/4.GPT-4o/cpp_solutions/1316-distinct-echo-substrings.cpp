class Solution {
public:
    int distinctEchoSubstrings(string text) {
        int n = text.size();
        unordered_set<string> seen;
        for (int len = 1; len <= n / 2; ++len) {
            unordered_set<string> current;
            for (int start = 0; start <= n - 2 * len; ++start) {
                string substr = text.substr(start, len);
                if (text.substr(start + len, len) == substr) {
                    current.insert(substr);
                }
            }
            seen.insert(current.begin(), current.end());
        }
        return seen.size();
    }
};