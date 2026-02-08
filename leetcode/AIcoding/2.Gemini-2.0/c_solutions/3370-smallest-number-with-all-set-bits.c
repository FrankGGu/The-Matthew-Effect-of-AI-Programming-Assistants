#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int smallestNumber(int n) {
    int result = 0;
    for (int i = 0; i < 32; i++) {
        if (n > 0) {
            result |= (1 << i);
            n--;
        } else {
            break;
        }
    }
    return result;
}