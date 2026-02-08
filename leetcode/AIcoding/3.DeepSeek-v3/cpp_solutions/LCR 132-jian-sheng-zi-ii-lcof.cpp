#include <vector>
#include <queue>
#include <cmath>

using namespace std;

class Solution {
public:
    int cuttingBamboo(int bamboo_len) {
        if (bamboo_len <= 3) return bamboo_len - 1;
        int mod = 1e9 + 7;
        long res = 1;
        while (bamboo_len > 4) {
            res = res * 3 % mod;
            bamboo_len -= 3;
        }
        return res * bamboo_len % mod;
    }
};