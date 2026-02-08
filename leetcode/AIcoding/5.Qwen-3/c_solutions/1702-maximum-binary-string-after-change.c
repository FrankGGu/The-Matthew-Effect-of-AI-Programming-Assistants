#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char* maximizeBinaryString(char* binary) {
    int n = strlen(binary);
    char* result = (char*)malloc((n + 1) * sizeof(char));
    int i, j;
    int countZero = 0;
    int firstOne = -1;

    for (i = 0; i < n; i++) {
        if (binary[i] == '0') {
            countZero++;
        } else {
            if (firstOne == -1) {
                firstOne = i;
            }
        }
    }

    if (countZero == 0 || firstOne == -1) {
        strcpy(result, binary);
        return result;
    }

    int pos = firstOne + countZero - 1;
    for (i = 0; i < n; i++) {
        if (i == pos) {
            result[i] = '1';
        } else if (i < firstOne) {
            result[i] = '0';
        } else {
            result[i] = '1';
        }
    }

    result[n] = '\0';
    return result;
}