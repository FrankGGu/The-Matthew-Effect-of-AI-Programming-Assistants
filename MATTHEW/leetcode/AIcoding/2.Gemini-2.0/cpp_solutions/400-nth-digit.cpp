using namespace std;

class Solution {
public:
    int findNthDigit(int n) {
        long long digits = 1, count = 9;
        while (n > digits * count) {
            n -= digits * count;
            digits++;
            count *= 10;
        }
        long long num = 1;
        for (int i = 1; i < digits; i++) {
            num *= 10;
        }
        num += (n - 1) / digits;
        string s = to_string(num);
        return s[(n - 1) % digits] - '0';
    }
};