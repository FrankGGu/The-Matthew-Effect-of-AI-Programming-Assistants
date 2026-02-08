#include <vector>

using namespace std;

class Solution {
public:
    int countWays(vector<vector<int>>& queries, int n, int k) {
        int mod = 1e9 + 7;
        int max_factors = 10001;
        vector<int> primes;
        vector<bool> is_prime(max_factors, true);
        is_prime[0] = is_prime[1] = false;
        for (int i = 2; i < max_factors; ++i) {
            if (is_prime[i]) {
                primes.push_back(i);
                for (long long j = (long long)i * i; j < max_factors; j += i) {
                    is_prime[j] = false;
                }
            }
        }

        vector<int> prime_factors(primes.size(), 0);
        if (k > 1) {
            for (int i = 0; i < primes.size(); ++i) {
                while (k % primes[i] == 0) {
                    prime_factors[i]++;
                    k /= primes[i];
                }
            }
        }

        if (k > 1) return vector<int>(queries.size(), 0);

        vector<vector<long long>> combinations(n + primes.size() + 1, vector<long long>(primes.size() + 1, 0));
        for (int i = 0; i <= n + primes.size(); ++i) {
            combinations[i][0] = 1;
            for (int j = 1; j <= min(i, (int)primes.size()); ++j) {
                combinations[i][j] = (combinations[i - 1][j - 1] + combinations[i - 1][j]) % mod;
            }
        }

        vector<int> result;
        for (auto& query : queries) {
            int target = query[1];
            vector<int> factors = prime_factors;
            bool possible = true;
            for (int i = 0; i < primes.size(); ++i) {
                if (target < factors[i]) {
                    possible = false;
                    break;
                }
            }
            if (!possible) {
                result.push_back(0);
                continue;
            }

            long long ways = 1;
            vector<int> required_factors = {};
            for(int i = 0; i < primes.size(); ++i){
                required_factors.push_back(prime_factors[i]);
            }

            ways = 1;
            for (int i = 0; i < primes.size(); ++i) {
                ways = (ways * combinations[query[0] + required_factors[i] - 1][required_factors[i]]) % mod;
            }

            result.push_back(ways);
        }

        return result;
    }
};