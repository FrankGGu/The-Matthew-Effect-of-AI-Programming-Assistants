class Solution {
public:
    string longestNiceSubstring(string s) {
        int maxLen = 0;
        string result = "";
        int n = s.size();

        for (int i = 0; i < n; ++i) {
            for (int j = i + 1; j < n; ++j) {
                string sub = s.substr(i, j - i + 1);
                if (isNice(sub) && sub.length() > maxLen) {
                    maxLen = sub.length();
                    result = sub;
                }
            }
        }
        return result;
    }

    bool isNice(const string& s) {
        unordered_set<char> lower, upper;
        for (char c : s) {
            if (islower(c)) lower.insert(c);
            else if (isupper(c)) upper.insert(c);
        }
        for (char c : lower) {
            if (upper.find(toupper(c)) == upper.end()) return false;
        }
        for (char c : upper) {
            if (lower.find(tolower(c)) == lower.end()) return false;
        }
        return true;
    }
};