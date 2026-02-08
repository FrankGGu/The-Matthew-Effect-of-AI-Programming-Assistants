class Solution {
public:
    int balancedStringSplit(string s) {
        int count = 0, balance = 0;
        for (char c : s) {
            balance += (c == 'L') ? 1 : -1;
            if (balance == 0) count++;
        }
        return count;
    }
};