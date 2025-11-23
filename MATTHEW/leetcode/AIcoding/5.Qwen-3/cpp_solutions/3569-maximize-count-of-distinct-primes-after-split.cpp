#include <iostream>
#include <vector>
#include <unordered_set>

using namespace std;

class Solution {
public:
    int maximumNumberOfPrimes(int n) {
        vector<bool> isPrime(n + 1, true);
        isPrime[0] = isPrime[1] = false;
        for (int i = 2; i * i <= n; ++i) {
            if (isPrime[i]) {
                for (int j = i * i; j <= n; j += i) {
                    isPrime[j] = false;
                }
            }
        }

        vector<int> primes;
        for (int i = 2; i <= n; ++i) {
            if (isPrime[i]) {
                primes.push_back(i);
            }
        }

        int count = 0;
        int left = 0, right = primes.size() - 1;
        while (left <= right) {
            if (primes[left] + primes[right] <= n) {
                count++;
                left++;
                right--;
            } else {
                right--;
            }
        }

        return count;
    }
};