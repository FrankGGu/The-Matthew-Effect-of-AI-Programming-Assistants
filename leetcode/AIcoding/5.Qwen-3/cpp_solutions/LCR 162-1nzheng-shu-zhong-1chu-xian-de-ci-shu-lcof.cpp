#include <iostream>
#include <vector>

using namespace std;

class Solution {
public:
    int countDigitOne(int n) {
        int count = 0;
        int i = 1;
        while (i <= n) {
            int divider = i * 10;
            count += (n / divider) * i;
            int remainder = n % i;
            if (remainder >= i * 2) {
                count += i;
            } else if (remainder >= i) {
                count += remainder - i + 1;
            }
            i *= 10;
        }
        return count;
    }
};