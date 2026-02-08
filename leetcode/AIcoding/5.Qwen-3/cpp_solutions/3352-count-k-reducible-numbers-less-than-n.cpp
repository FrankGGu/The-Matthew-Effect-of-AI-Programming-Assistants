#include <iostream>
#include <vector>
#include <unordered_set>

using namespace std;

class Solution {
public:
    int countKReducibleNumbersLessThanN(int N, int K) {
        vector<int> primes;
        vector<bool> is_prime(N + 1, true);
        is_prime[0] = is_prime[1] = false;
        for (int i = 2; i <= N; ++i) {
            if (is_prime[i]) {
                primes.push_back(i);
                for (int j = i * i; j <= N; j += i) {
                    is_prime[j] = false;
                }
            }
        }

        unordered_set<int> k_reducible;
        for (int p : primes) {
            int multiple = p * K;
            while (multiple <= N) {
                k_reducible.insert(multiple);
                multiple += p * K;
            }
        }

        return k_reducible.size();
    }
};