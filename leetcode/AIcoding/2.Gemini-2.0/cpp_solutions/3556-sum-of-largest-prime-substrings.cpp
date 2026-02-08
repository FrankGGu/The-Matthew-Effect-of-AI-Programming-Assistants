#include <string>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    long long sumOfMaxPrimeSubstrings(string s) {
        long long ans = 0;
        for (int i = 0; i < s.length(); ++i) {
            long long max_prime = 0;
            for (int j = i; j < s.length(); ++j) {
                string sub = s.substr(i, j - i + 1);
                long long num = stoll(sub);
                if (isPrime(num) && num <= 100000) {
                    max_prime = max(max_prime, num);
                }
            }
            ans += max_prime;
        }
        return ans;
    }

private:
    bool isPrime(long long n) {
        if (n <= 1) return false;
        for (long long i = 2; i * i <= n; ++i) {
            if (n % i == 0) return false;
        }
        return true;
    }
};