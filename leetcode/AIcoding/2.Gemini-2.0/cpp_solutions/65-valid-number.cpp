class Solution {
public:
    bool isNumber(string s) {
        int i = 0;
        while (i < s.size() && s[i] == ' ') i++;
        if (i < s.size() && (s[i] == '+' || s[i] == '-')) i++;
        bool isNumeric = false;
        while (i < s.size() && isdigit(s[i])) {
            isNumeric = true;
            i++;
        }
        if (i < s.size() && s[i] == '.') {
            i++;
            while (i < s.size() && isdigit(s[i])) {
                isNumeric = true;
                i++;
            }
        }
        if (isNumeric && i < s.size() && (s[i] == 'e' || s[i] == 'E')) {
            i++;
            isNumeric = false;
            if (i < s.size() && (s[i] == '+' || s[i] == '-')) i++;
            while (i < s.size() && isdigit(s[i])) {
                isNumeric = true;
                i++;
            }
        }
        while (i < s.size() && s[i] == ' ') i++;
        return isNumeric && i == s.size();
    }
};