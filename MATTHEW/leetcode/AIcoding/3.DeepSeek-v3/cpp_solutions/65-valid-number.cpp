class Solution {
public:
    bool isNumber(string s) {
        bool digitSeen = false, dotSeen = false, eSeen = false;
        int countPlusMinus = 0;

        for (int i = 0; i < s.size(); ++i) {
            char c = s[i];
            if (isdigit(c)) {
                digitSeen = true;
            } else if (c == '+' || c == '-') {
                if (countPlusMinus == 2) {
                    return false;
                }
                if (i > 0 && (s[i-1] != 'e' && s[i-1] != 'E')) {
                    return false;
                }
                if (i == s.size() - 1) {
                    return false;
                }
                countPlusMinus++;
            } else if (c == '.') {
                if (dotSeen || eSeen) {
                    return false;
                }
                if (i == s.size() - 1 && !digitSeen) {
                    return false;
                }
                dotSeen = true;
            } else if (c == 'e' || c == 'E') {
                if (eSeen || !digitSeen || i == s.size() - 1) {
                    return false;
                }
                eSeen = true;
            } else {
                return false;
            }
        }
        return true;
    }
};