class Solution {
public:
    bool isNumber(string s) {
        int i = 0;
        while (i < s.size() && s[i] == ' ') i++;
        if (i < s.size() && (s[i] == '+' || s[i] == '-')) i++;
        bool is_digit = false;
        while (i < s.size() && isdigit(s[i])) {
            is_digit = true;
            i++;
        }
        if (i < s.size() && s[i] == '.') {
            i++;
            while (i < s.size() && isdigit(s[i])) {
                is_digit = true;
                i++;
            }
        }
        if (i < s.size() && (s[i] == 'e' || s[i] == 'E')) {
            if (!is_digit) return false;
            i++;
            is_digit = false;
            if (i < s.size() && (s[i] == '+' || s[i] == '-')) i++;
            while (i < s.size() && isdigit(s[i])) {
                is_digit = true;
                i++;
            }
            if (!is_digit) return false;
        }
        while (i < s.size() && s[i] == ' ') i++;
        return i == s.size();
    }
};