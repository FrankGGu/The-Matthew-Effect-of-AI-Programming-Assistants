using namespace std;

class Solution {
public:
    int maxNiceDivisors(int primeFactors) {
        if (primeFactors <= 3) {
            return primeFactors;
        }

        long long mod = 1000000007;

        if (primeFactors % 3 == 0) {
            long long base = 3;
            long long exponent = primeFactors / 3;
            long long result = 1;

            while (exponent > 0) {
                if (exponent % 2 == 1) {
                    result = (result * base) % mod;
                }
                base = (base * base) % mod;
                exponent /= 2;
            }
            return result;
        } else if (primeFactors % 3 == 1) {
            long long base = 3;
            long long exponent = (primeFactors - 4) / 3;
            long long result = 1;

            while (exponent > 0) {
                if (exponent % 2 == 1) {
                    result = (result * base) % mod;
                }
                base = (base * base) % mod;
                exponent /= 2;
            }
            return (result * 4) % mod;
        } else {
            long long base = 3;
            long long exponent = (primeFactors - 2) / 3;
            long long result = 1;

            while (exponent > 0) {
                if (exponent % 2 == 1) {
                    result = (result * base) % mod;
                }
                base = (base * base) % mod;
                exponent /= 2;
            }
            return (result * 2) % mod;
        }
    }
};