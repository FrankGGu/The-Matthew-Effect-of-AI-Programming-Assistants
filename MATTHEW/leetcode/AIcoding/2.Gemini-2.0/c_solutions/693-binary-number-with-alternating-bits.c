#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool hasAlternatingBits(int n) {
    int prev_bit = -1;
    while (n > 0) {
        int current_bit = n % 2;
        if (prev_bit != -1 && current_bit == prev_bit) {
            return false;
        }
        prev_bit = current_bit;
        n /= 2;
    }
    return true;
}