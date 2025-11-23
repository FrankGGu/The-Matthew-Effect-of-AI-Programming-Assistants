#include <iostream>
#include <vector>
#include <unordered_map>
#include <cmath>

using namespace std;

class Solution {
public:
    int idealArrays(int n, vector<int>& queries) {
        const int MOD = 1e9 + 7;
        unordered_map<int, int> primeFactors;

        for (int num : queries) {
            int x = num;
            for (int i = 2; i * i <= x; ++i) {
                while (x % i == 0) {
                    primeFactors[i]++;
                    x /= i;
                }
            }
            if (x > 1) {
                primeFactors[x]++;
            }
        }

        long long result = 1;
        for (auto& [p, cnt] : primeFactors) {
            long long ways = 1;
            for (int i = 1; i <= cnt; ++i) {
                ways = ways * (n - 1 + i) / i;
                ways %= MOD;
            }
            result = result * ways % MOD;
        }

        return static_cast<int>(result);
    }
};