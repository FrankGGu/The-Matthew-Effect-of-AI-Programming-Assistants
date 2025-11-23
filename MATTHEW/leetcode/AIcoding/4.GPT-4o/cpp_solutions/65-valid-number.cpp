class Solution {
public:
    bool isNumber(string s) {
        int n = s.size(), i = 0;
        while (i < n && s[i] == ' ') i++;
        if (i == n) return false;

        if (s[i] == '+' || s[i] == '-') i++;
        bool hasNum = false, hasDot = false, hasE = false;

        while (i < n) {
            if (isdigit(s[i])) {
                hasNum = true;
            } else if (s[i] == '.') {
                if (hasDot || hasE) return false;
                hasDot = true;
            } else if (s[i] == 'e' || s[i] == 'E') {
                if (hasE || !hasNum) return false;
                hasE = true;
                hasNum = false;
                i++;
                if (i < n && (s[i] == '+' || s[i] == '-')) i++;
            } else {
                return false;
            }
            i++;
        }

        while (i > 0 && s[i - 1] == ' ') i--;
        return hasNum && i == n;
    }
};