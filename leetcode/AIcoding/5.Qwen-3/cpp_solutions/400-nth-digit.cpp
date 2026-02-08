#include <iostream>
#include <cmath>

using namespace std;

class Solution {
public:
    int findNthDigit(int n) {
        long long digits = 1;
        long long count = 9;
        long long start = 1;

        while (n > digits * count) {
            n -= digits * count;
            digits++;
            count *= 10;
            start *= 10;
        }

        long long number = start + (n - 1) / digits;
        long long index = (n - 1) % digits;

        return to_string(number)[index] - '0';
    }
};