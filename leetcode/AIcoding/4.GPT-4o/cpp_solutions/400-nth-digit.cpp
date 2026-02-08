class Solution {
public:
    int findNthDigit(int n) {
        long long base = 1, count = 9, digits = 1;
        while (n > count) {
            n -= count;
            digits++;
            base *= 10;
            count = digits * base * 9;
        }
        base += (n - 1) / digits;
        string num = to_string(base);
        return num[(n - 1) % digits] - '0';
    }
};