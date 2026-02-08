#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char *maximumNumber(char *num, int *change, int changeSize) {
    int n = strlen(num);
    int mutated = 0;
    for (int i = 0; i < n; i++) {
        int digit = num[i] - '0';
        if (change[digit] > digit) {
            num[i] = change[digit] + '0';
            mutated = 1;
        } else if (change[digit] < digit && mutated) {
            break;
        } else if (change[digit] == digit && mutated) {
            continue;
        }
    }
    return num;
}