#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int addDigits(int num) {
    if (num == 0) return 0;
    if (num % 9 == 0) return 9;
    return num % 9;
}