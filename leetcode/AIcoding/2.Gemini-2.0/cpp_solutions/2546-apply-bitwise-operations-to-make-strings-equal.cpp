class Solution {
public:
    bool makeStringsEqual(string s1, string s2) {
        int n = s1.size();
        bool hasOneS1 = false;
        bool hasOneS2 = false;

        for (int i = 0; i < n; ++i) {
            if (s1[i] == '1') {
                hasOneS1 = true;
            }
            if (s2[i] == '1') {
                hasOneS2 = true;
            }
        }

        if (hasOneS1 == hasOneS2) {
            return true;
        } else {
            return false;
        }
    }
};