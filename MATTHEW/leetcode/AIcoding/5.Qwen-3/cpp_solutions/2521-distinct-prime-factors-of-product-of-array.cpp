#include <iostream>
#include <vector>
#include <unordered_set>

using namespace std;

class Solution {
public:
    int distinctPrimeFactors(vector<int>& nums) {
        unordered_set<int> primes;
        for (int num : nums) {
            int n = num;
            for (int i = 2; i * i <= n; ++i) {
                if (n % i == 0) {
                    primes.insert(i);
                    while (n % i == 0) {
                        n /= i;
                    }
                }
            }
            if (n > 1) {
                primes.insert(n);
            }
        }
        return primes.size();
    }
};