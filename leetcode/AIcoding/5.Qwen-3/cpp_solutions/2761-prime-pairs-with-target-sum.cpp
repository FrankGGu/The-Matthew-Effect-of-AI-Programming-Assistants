#include <iostream>
#include <vector>
#include <cmath>

class Solution {
public:
    std::vector<std::vector<int>> primePairs(int n) {
        std::vector<bool> isPrime(n + 1, true);
        isPrime[0] = isPrime[1] = false;
        for (int i = 2; i * i <= n; ++i) {
            if (isPrime[i]) {
                for (int j = i * i; j <= n; j += i) {
                    isPrime[j] = false;
                }
            }
        }

        std::vector<std::vector<int>> result;
        for (int i = 2; i <= n / 2; ++i) {
            if (isPrime[i] && isPrime[n - i]) {
                result.push_back({i, n - i});
            }
        }
        return result;
    }
};