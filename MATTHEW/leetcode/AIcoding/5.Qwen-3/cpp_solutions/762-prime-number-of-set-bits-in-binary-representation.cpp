#include <iostream>
#include <vector>
#include <cmath>

class Solution {
public:
    int countPrimeSetBits(int left, int right) {
        std::vector<bool> isPrime(32, false);
        for (int i = 2; i <= 31; ++i) {
            bool prime = true;
            for (int j = 2; j <= sqrt(i); ++j) {
                if (i % j == 0) {
                    prime = false;
                    break;
                }
            }
            if (prime) {
                isPrime[i] = true;
            }
        }

        int count = 0;
        for (int num = left; num <= right; ++num) {
            int bits = 0;
            int n = num;
            while (n > 0) {
                bits += n & 1;
                n >>= 1;
            }
            if (isPrime[bits]) {
                ++count;
            }
        }
        return count;
    }
};