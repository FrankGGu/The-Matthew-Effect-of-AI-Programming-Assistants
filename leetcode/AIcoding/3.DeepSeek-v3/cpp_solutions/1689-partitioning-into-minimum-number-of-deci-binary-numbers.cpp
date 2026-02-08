class Solution {
public:
    int minPartitions(string n) {
        int maxDigit = 0;
        for (char c : n) {
            int digit = c - '0';
            if (digit > maxDigit) {
                maxDigit = digit;
            }
        }
        return maxDigit;
    }
};