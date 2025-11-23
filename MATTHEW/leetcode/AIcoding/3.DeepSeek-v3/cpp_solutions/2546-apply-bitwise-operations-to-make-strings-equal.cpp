class Solution {
public:
    bool makeStringsEqual(string s, string target) {
        int n = s.size();
        bool hasOneS = false, hasOneTarget = false;
        for (int i = 0; i < n; ++i) {
            if (s[i] == '1') {
                hasOneS = true;
                break;
            }
        }
        for (int i = 0; i < n; ++i) {
            if (target[i] == '1') {
                hasOneTarget = true;
                break;
            }
        }
        if (hasOneS != hasOneTarget) {
            return false;
        }
        return true;
    }
};