#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int countKReduibleNumbers(int n, int k) {
        vector<bool> is_prime(n, true);
        is_prime[0] = is_prime[1] = false;
        for (int i = 2; i * i < n; ++i) {
            if (is_prime[i]) {
                for (int j = i * i; j < n; j += i) {
                    is_prime[j] = false;
                }
            }
        }

        vector<int> primes;
        for (int i = 2; i < n; ++i) {
            if (is_prime[i]) {
                primes.push_back(i);
            }
        }

        int count = 0;
        for (int num = 2; num < n; ++num) {
            int x = num;
            int steps = 0;
            while (x != 1) {
                if (is_prime[x]) {
                    x = 1;
                } else {
                    for (int p : primes) {
                        if (p * p > x) {
                            x = 1;
                            break;
                        }
                        if (x % p == 0) {
                            x = x / p;
                            break;
                        }
                    }
                }
                steps++;
                if (steps > k) {
                    break;
                }
            }
            if (steps == k) {
                count++;
            }
        }
        return count;
    }
};