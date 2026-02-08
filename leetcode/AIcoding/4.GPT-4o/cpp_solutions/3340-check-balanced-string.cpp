class Solution {
public:
    bool checkBalancedString(string s) {
        int balance = 0;
        for (char c : s) {
            if (c == 'L') balance++;
            else if (c == 'R') balance--;
            else if (c == 'X') continue; // 'X' can be ignored
        }
        return balance == 0;
    }
};