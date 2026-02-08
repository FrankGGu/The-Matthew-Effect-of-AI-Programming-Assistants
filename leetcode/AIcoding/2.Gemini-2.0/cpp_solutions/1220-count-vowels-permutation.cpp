#include <vector>

using namespace std;

class Solution {
public:
    int countVowelPermutation(int n) {
        long long a = 1, e = 1, i = 1, o = 1, u = 1;
        long long mod = 1e9 + 7;
        for (int j = 1; j < n; ++j) {
            long long a_new = (e + i + u) % mod;
            long long e_new = (a + i) % mod;
            long long i_new = (e + o) % mod;
            long long o_new = (i) % mod;
            long long u_new = (i + o) % mod;
            a = a_new;
            e = e_new;
            i = i_new;
            o = o_new;
            u = u_new;
        }
        return (a + e + i + o + u) % mod;
    }
};