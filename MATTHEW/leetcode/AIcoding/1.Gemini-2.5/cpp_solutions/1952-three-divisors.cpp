#include <cmath>

class Solution {
public:
    bool isPrime(int num) {
        if (num <= 1) {
            return false;
        }
        for (int i = 2; i * i <= num; ++i) {
            if (num % i == 0) {
                return false;
            }
        }
        return true;
    }

    bool threeDivisors(int n) {
        if (n < 4) {
            return false;
        }

        long long root = round(sqrt(n));

        if (root * root != n) {
            return false;
        }

        return isPrime(root);
    }
};