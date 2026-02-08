class Solution {
public:
    std::string maximumTime(std::string s) {
        // Handle hours
        if (s[0] == '?') {
            if (s[1] == '?' || (s[1] >= '0' && s[1] <= '3')) {
                s[0] = '2';
            } else { // s[1] is '4' through '9'
                s[0] = '1';
            }
        }
        if (s[1] == '?') {
            if (s[0] == '2') {
                s[1] = '3';
            } else { // s[0] is '0' or '1'
                s[1] = '9';
            }
        }

        // Handle minutes
        if (s[3] == '?') {
            s[3] = '5';
        }
        if (s[4] == '?') {
            s[4] = '9';
        }

        return s;
    }
};