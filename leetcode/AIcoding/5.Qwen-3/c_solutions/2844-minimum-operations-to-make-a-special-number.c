#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int minimumOperationsToMakeASpecialNumber(char *num) {
    int n = strlen(num);
    int min_ops = 0;
    for (int i = 0; i < n; i++) {
        if (num[i] == '0') {
            min_ops++;
        }
    }
    if (min_ops > 0) {
        return min_ops;
    }
    return n;
}