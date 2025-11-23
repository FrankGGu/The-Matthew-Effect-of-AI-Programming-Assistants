#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int nthMagicalNumber(int n, int k) {
        long long MOD = 1e9 + 7;
        long long low = 1, high = (long long)k * (long long)n;
        long long lcm = (long long)k * (long long)n / gcd(k, n);

        while (low < high) {
            long long mid = (low + high) / 2;
            long long count = mid / k + mid / n - mid / lcm;
            if (count < n)
                low = mid + 1;
            else
                high = mid;
        }

        return (int)(low % MOD);
    }

private:
    long long gcd(long long a, long long b) {
        while (b != 0) {
            long long temp = b;
            b = a % b;
            a = temp;
        }
        return a;
    }
};