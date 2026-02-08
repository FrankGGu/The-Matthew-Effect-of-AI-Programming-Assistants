#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char * getHappyString(int n, int k){
    int total = 3 * (1 << (n - 1));
    if (k > total) {
        return "";
    }

    char *result = (char *)malloc(sizeof(char) * (n + 1));
    result[n] = '\0';

    k--;
    int choice = k / (1 << (n - 1));
    if (choice == 0) {
        result[0] = 'a';
    } else if (choice == 1) {
        result[0] = 'b';
    } else {
        result[0] = 'c';
    }

    k %= (1 << (n - 1));

    for (int i = 1; i < n; i++) {
        int bit = (k >> (n - 1 - i)) & 1;
        if (result[i - 1] == 'a') {
            result[i] = (bit == 0) ? 'b' : 'c';
        } else if (result[i - 1] == 'b') {
            result[i] = (bit == 0) ? 'a' : 'c';
        } else {
            result[i] = (bit == 0) ? 'a' : 'b';
        }
    }

    return result;
}