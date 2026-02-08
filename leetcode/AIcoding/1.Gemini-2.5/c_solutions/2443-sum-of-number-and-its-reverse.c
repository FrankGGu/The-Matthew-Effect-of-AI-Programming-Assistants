#include <stdbool.h>

int reverse(int n) {
    int reversed_n = 0;
    while (n > 0) {
        reversed_n = reversed_n * 10 + (n % 10);
        n /= 10;
    }
    return reversed_n;
}

bool sumOfNumberAndReverse(int num) {
    for (int x = 0; x <= num; x++) {
        if (x + reverse(x) == num) {
            return true;
        }
    }
    return false;
}