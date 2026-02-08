#include <string>
#include <algorithm>

using namespace std;

class Solution {
public:
    int makeTheIntegerZero(int num1, int num2) {
        if (num2 >= num1) return -1;

        for (int k = 1; k <= 60; ++k) {
            long long diff = (long long)num1 - (long long)k * num2;
            if (diff <= 0) continue;
            long long bits = __builtin_popcountll(diff);
            if (bits <= k && k <= diff) return k;
        }

        return -1;
    }
};