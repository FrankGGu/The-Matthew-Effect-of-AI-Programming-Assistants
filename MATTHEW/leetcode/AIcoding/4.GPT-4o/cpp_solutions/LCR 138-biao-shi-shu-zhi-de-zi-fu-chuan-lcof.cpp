class Solution {
public:
    bool isNumber(string s) {
        int n = s.size(), i = 0;
        while (i < n && s[i] == ' ') i++;
        if (i == n) return false;
        if (s[i] == '+' || s[i] == '-') i++;
        bool numeric = false;
        while (i < n && isdigit(s[i])) {
            numeric = true;
            i++;
        }
        if (i < n && s[i] == '.') {
            i++;
            while (i < n && isdigit(s[i])) {
                numeric = true;
                i++;
            }
        }
        if (numeric && i < n && (s[i] == 'e' || s[i] == 'E')) {
            i++;
            if (i < n && (s[i] == '+' || s[i] == '-')) i++;
            numeric = false;
            while (i < n && isdigit(s[i])) {
                numeric = true;
                i++;
            }
        }
        while (i < n && s[i] == ' ') i++;
        return numeric && i == n;
    }
};