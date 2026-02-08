#include <limits.h>

int reverse(int x) {
    long long reversed_num = 0; 

    while (x != 0) {
        int digit = x % 10;

        if (reversed_num > INT_MAX / 10 || (reversed_num == INT_MAX / 10 && digit > 7)) {
            return 0;
        }
        if (reversed_num < INT_MIN / 10 || (reversed_num == INT_MIN / 10 && digit < -8)) {
            return 0;
        }

        reversed_num = reversed_num * 10 + digit;
        x /= 10;
    }

    return (int)reversed_num;
}