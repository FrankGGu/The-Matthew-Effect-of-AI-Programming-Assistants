class Solution {
public:
    bool isValid(string s) {
        for (int i = 0; i < s.size() - 1; ++i) {
            int a = s[i] - '0';
            int b = s[i + 1] - '0';
            if (a + b == 10) {
                return true;
            }
        }
        return false;
    }
};