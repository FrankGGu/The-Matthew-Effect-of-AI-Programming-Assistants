#include <iostream>
#include <vector>
#include <algorithm>
#include <string>
#include <cmath>

using namespace std;

class Solution {
public:
    bool isPowerOfTwo(long long n) {
        return n > 0 && (n & (n - 1)) == 0;
    }

    string countDigits(long long n) {
        string s = "";
        for (int i = 0; i < 10; ++i) {
            s += to_string(n % 10);
            n /= 10;
        }
        sort(s.begin(), s.end());
        return s;
    }

    bool reorderedPowerOf2(long long N) {
        string target = countDigits(N);
        for (long long i = 0; i < 31; ++i) {
            if (countDigits(1LL << i) == target) {
                return true;
            }
        }
        return false;
    }
};