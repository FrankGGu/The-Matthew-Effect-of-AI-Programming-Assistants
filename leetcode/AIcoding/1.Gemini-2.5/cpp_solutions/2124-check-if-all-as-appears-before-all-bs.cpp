class Solution {
public:
    bool checkString(string s) {
        bool bFound = false;
        for (char c : s) {
            if (c == 'b') {
                bFound = true;
            } else if (c == 'a' && bFound) {
                return false;
            }
        }
        return true;
    }
};