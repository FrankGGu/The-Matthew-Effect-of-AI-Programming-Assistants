#include <iostream>
#include <vector>
#include <string>
#include <cmath>

using namespace std;

class Solution {
public:
    long long makeIntegerBeautiful(long long n) {
        long long original = n;
        long long add = 0;
        int digit = 1;

        while (n > 0) {
            long long next = (n / 10 + 1) * 10;
            add = next - original;
            if (add > 0) return add;
            digit *= 10;
            n /= 10;
        }

        return 10;
    }
};