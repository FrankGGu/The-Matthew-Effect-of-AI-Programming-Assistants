#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char * maximumBinaryString(char * binary) {
    int zeros = 0;
    int ones = 0;
    int n = strlen(binary);

    for (int i = 0; i < n; i++) {
        if (binary[i] == '0') {
            zeros++;
        } else {
            ones++;
        }
    }

    if (zeros == 0) {
        return binary;
    }

    for (int i = 0; i < n; i++) {
        if (zeros > 1) {
            binary[i] = '1';
        } else if (zeros == 1) {
            binary[i] = '0';
        } else {
            binary[i] = '1';
        }
    }

    binary[n - zeros] = '0';

    return binary;
}