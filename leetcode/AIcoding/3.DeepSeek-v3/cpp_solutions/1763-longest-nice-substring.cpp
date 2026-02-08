class Solution {
public:
    string longestNiceSubstring(string s) {
        if (s.size() < 2) return "";
        unordered_set<char> set(s.begin(), s.end());
        for (int i = 0; i < s.size(); ++i) {
            char c = s[i];
            if (set.find(toupper(c)) == set.end() || set.find(tolower(c)) == set.end()) {
                string left = longestNiceSubstring(s.substr(0, i));
                string right = longestNiceSubstring(s.substr(i + 1));
                return left.size() >= right.size() ? left : right;
            }
        }
        return s;
    }
};