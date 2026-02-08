class Solution {
public:
    int smallestNumber(long long n) {
        if (n == 1) return 1;
        for (long long i = 1; ; ++i) {
            long long product = 1;
            long long num = i;
            while (num > 0) {
                int digit = num % 10;
                if (digit == 0) {
                    product = 0;
                    break;
                }
                product *= digit;
                num /= 10;
            }
            if (product != 0 && i % n == 0 && product % n == 0) {
                return i;
            }
        }
        return -1;
    }
};