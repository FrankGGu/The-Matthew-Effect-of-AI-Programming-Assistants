class Solution {
public:
    int countDigitOne(int n) {
        long long count = 0;
        long long factor = 1;
        long long current;

        for (int i = 0; i < 10; i++) {
            current = n / factor;
            long long lowerNumbers = n - current * factor;
            long long currDigit = current % 10;
            current /= 10;

            if (currDigit == 0) {
                count += current * factor;
            } else if (currDigit == 1) {
                count += current * factor + lowerNumbers + 1;
            } else {
                count += (current + 1) * factor;
            }

            factor *= 10;
        }
        return count;
    }
};