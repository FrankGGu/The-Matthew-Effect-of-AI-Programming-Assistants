class Solution {
public:
    string greatestLetter(string s) {
        vector<bool> lower(26, false), upper(26, false);
        for (char c : s) {
            if (islower(c)) {
                lower[c - 'a'] = true;
            } else if (isupper(c)) {
                upper[c - 'A'] = true;
            }
        }
        for (char c = 'Z'; c >= 'A'; --c) {
            if (upper[c - 'A'] && lower[c - 'A' + 32]) {
                return string(1, c);
            }
        }
        return "";
    }
};