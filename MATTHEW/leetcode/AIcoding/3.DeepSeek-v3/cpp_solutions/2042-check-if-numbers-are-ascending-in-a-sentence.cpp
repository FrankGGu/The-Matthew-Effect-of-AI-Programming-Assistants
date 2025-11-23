class Solution {
public:
    bool areNumbersAscending(string s) {
        int prev = -1;
        int current = 0;
        for (int i = 0; i < s.size(); ++i) {
            if (isdigit(s[i])) {
                current = current * 10 + (s[i] - '0');
            } else if (current != 0) {
                if (current <= prev) {
                    return false;
                }
                prev = current;
                current = 0;
            }
        }
        if (current != 0 && current <= prev) {
            return false;
        }
        return true;
    }
};