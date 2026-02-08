#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool doesValidArrayExist(int* derived, int derivedSize) {
    int first = 0;
    for (int i = 0; i < derivedSize; i++) {
        first ^= derived[i];
    }
    return first == 0;
}