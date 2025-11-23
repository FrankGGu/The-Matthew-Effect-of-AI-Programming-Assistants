#include <stdio.h>
#include <stdlib.h>

int minimumNumbers(int num, int k) {
    if (num < k) return -1;
    if (k == 0) {
        return num % 10 == 0 ? 0 : -1;
    }
    for (int i = 0; i <= num; i += 10) {
        if ((num - i) % k == 0 && (num - i) >= 0) {
            return i / 10 + (num - i) / k;
        }
    }
    return -1;
}