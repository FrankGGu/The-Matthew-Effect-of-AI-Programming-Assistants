#include <iostream>
#include <vector>
#include <unordered_set>
#include <cmath>

class Solution {
public:
    int sumOfGoodNumbers(int n) {
        std::unordered_set<int> primes;
        std::vector<bool> isPrime(n + 1, true);
        isPrime[0] = isPrime[1] = false;
        for (int i = 2; i * i <= n; ++i) {
            if (isPrime[i]) {
                for (int j = i * i; j <= n; j += i) {
                    isPrime[j] = false;
                }
            }
        }
        for (int i = 2; i <= n; ++i) {
            if (isPrime[i]) {
                primes.insert(i);
            }
        }

        int result = 0;
        for (int num = 2; num <= n; ++num) {
            int temp = num;
            bool isGood = true;
            while (temp > 0) {
                int digit = temp % 10;
                if (primes.find(digit) == primes.end()) {
                    isGood = false;
                    break;
                }
                temp /= 10;
            }
            if (isGood) {
                result += num;
            }
        }
        return result;
    }
};