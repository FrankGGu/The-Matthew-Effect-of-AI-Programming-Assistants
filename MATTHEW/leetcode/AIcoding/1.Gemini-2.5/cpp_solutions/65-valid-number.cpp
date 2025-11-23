class Solution {
public:
    bool isNumber(string s) {
        int i = 0;
        int n = s.length();

        while (i < n && s[i] == ' ') {
            i++;
        }

        if (i == n) {
            return false;
        }

        if (s[i] == '+' || s[i] == '-') {
            i++;
        }

        bool num_seen = false;
        bool dot_seen = false;
        bool e_seen = false;

        while (i < n) {
            char c = s[i];
            if (isdigit(c)) {
                num_seen = true;
            } else if (c == '.') {
                if (dot_seen || e_seen) {
                    return false;
                }
                dot_seen = true;
            } else if (c == 'e' || c == 'E') {
                if (e_seen || !num_seen) {
                    return false;
                }
                e_seen = true;
                num_seen = false;
            } else if (c == '+' || c == '-') {
                if (i == 0 || !(s[i-1] == 'e' || s[i-1] == 'E')) {
                    return false;
                }
            } else if (c == ' ') {
                break;
            } else {
                return false;
            }
            i++;
        }

        if (!num_seen) {
            return false;
        }

        while (i < n && s[i] == ' ') {
            i++;
        }

        return i == n;
    }
};