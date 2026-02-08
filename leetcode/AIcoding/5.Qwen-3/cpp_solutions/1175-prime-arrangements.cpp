#include <iostream>
#include <vector>

class Solution {
public:
    int numPrimeArrangements(int n) {
        int count = 0;
        for (int i = 2; i <= n; ++i) {
            bool isPrime = true;
            for (int j = 2; j * j <= i; ++j) {
                if (i % j == 0) {
                    isPrime = false;
                    break;
                }
            }
            if (isPrime) ++count;
        }
        int primes = count;
        int nonPrimes = n - primes;
        long long result = 1;
        for (int i = 1; i <= primes; ++i) {
            result *= i;
        }
        for (int i = 1; i <= nonPrimes; ++i) {
            result *= i;
        }
        return static_cast<int>(result);
    }
};