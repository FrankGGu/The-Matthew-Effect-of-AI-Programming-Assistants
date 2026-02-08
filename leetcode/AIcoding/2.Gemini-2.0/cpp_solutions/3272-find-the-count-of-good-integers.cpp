#include <vector>

using namespace std;

class Solution {
public:
    int countGoodNumbers(long long n) {
        long long odd_cnt = (n + 1) / 2;
        long long even_cnt = n / 2;
        long long mod = 1000000007;

        long long ans = 1;
        long long base_5 = 5;
        while (odd_cnt > 0) {
            if (odd_cnt % 2 == 1) {
                ans = (ans * base_5) % mod;
            }
            base_5 = (base_5 * base_5) % mod;
            odd_cnt /= 2;
        }

        long long base_4 = 4;
        while (even_cnt > 0) {
            if (even_cnt % 2 == 1) {
                ans = (ans * base_4) % mod;
            }
            base_4 = (base_4 * base_4) % mod;
            even_cnt /= 2;
        }

        return (int)ans;
    }
};