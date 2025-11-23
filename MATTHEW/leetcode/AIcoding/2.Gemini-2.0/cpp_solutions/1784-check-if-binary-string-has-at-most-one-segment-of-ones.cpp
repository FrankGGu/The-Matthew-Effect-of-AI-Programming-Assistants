class Solution {
public:
    bool checkOnesSegment(string s) {
        bool foundZero = false;
        for (char c : s) {
            if (c == '0') {
                foundZero = true;
            } else if (foundZero) {
                return false;
            }
        }
        return true;
    }
};