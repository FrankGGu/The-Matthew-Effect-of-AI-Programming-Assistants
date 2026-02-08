#include <vector>

using namespace std;

class Solution {
public:
    int countVowelPermutation(int n) {
        long long a = 1, e = 1, i = 1, o = 1, u = 1;
        long long mod = 1e9 + 7;
        for (int j = 1; j < n; j++) {
            long long new_a = (e + i + u) % mod;
            long long new_e = (a + i) % mod;
            long long new_i = (e + o) % mod;
            long long new_o = i % mod;
            long long new_u = (i + o) % mod;
            a = new_a;
            e = new_e;
            i = new_i;
            o = new_o;
            u = new_u;
        }
        return (a + e + i + o + u) % mod;
    }
};