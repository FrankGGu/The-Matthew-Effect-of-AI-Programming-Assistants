#include <stdbool.h>

int calculate_gcd(int a, int b) {
    while (b != 0) {
        int temp = b;
        b = a % b;
        a = temp;
    }
    return a;
}

bool isReachable(int tx, int ty) {
    return calculate_gcd(tx, ty) == 1;
}