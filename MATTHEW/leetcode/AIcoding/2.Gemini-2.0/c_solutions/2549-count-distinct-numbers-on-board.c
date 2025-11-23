#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int distinctIntegers(int n) {
    if (n == 1) {
        return 1;
    }
    return n - 1;
}