#include <iostream>
#include <vector>
#include <unordered_map>

using namespace std;

class Solution {
public:
    int countVowelPermutation(int n) {
        long long a = 1, e = 1, i = 1, o = 1, u = 1;
        const int MOD = 1000000007;

        for (int j = 1; j < n; ++j) {
            long long new_a = (e + i + u) % MOD;
            long long new_e = (a + i) % MOD;
            long long new_i = (e + o) % MOD;
            long long new_o = (i) % MOD;
            long long new_u = (i + o) % MOD;

            a = new_a;
            e = new_e;
            i = new_i;
            o = new_o;
            u = new_u;
        }

        return (a + e + i + o + u) % MOD;
    }
};