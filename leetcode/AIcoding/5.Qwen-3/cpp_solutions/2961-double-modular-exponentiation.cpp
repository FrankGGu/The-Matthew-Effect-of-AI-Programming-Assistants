#include <iostream>
#include <vector>

using namespace std;

class Solution {
public:
    int modExp(int a, int b, int mod) {
        int result = 1;
        a = a % mod;
        while (b > 0) {
            if (b % 2 == 1) {
                result = (result * a) % mod;
            }
            a = (a * a) % mod;
            b = b / 2;
        }
        return result;
    }

    int doubleModularExponentiation(vector<int>& x, vector<int>& y, vector<int>& z) {
        int n = x.size();
        int result = 0;
        for (int i = 0; i < n; ++i) {
            int exp = modExp(x[i], y[i], z[i]);
            result = (result + exp) % z[i];
        }
        return result;
    }
};