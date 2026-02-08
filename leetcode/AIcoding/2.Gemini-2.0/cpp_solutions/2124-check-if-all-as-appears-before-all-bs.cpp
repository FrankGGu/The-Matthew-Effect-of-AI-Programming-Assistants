class Solution {
public:
    bool checkString(string s) {
        bool b_found = false;
        for (char c : s) {
            if (c == 'b') {
                b_found = true;
            } else if (b_found && c == 'a') {
                return false;
            }
        }
        return true;
    }
};