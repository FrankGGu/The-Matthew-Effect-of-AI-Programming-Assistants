class Solution {
public:
    string makeFancyString(string s) {
        if (s.empty()) return s;
        string res;
        res += s[0];
        int count = 1;
        for (int i = 1; i < s.size(); ++i) {
            if (s[i] == s[i-1]) {
                count++;
            } else {
                count = 1;
            }
            if (count < 3) {
                res += s[i];
            }
        }
        return res;
    }
};