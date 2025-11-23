#include <string.h>
#include <stdio.h>

int getLucky(char * s, int k){
    char numStr[201];
    int current_idx = 0;

    for (int i = 0; s[i] != '\0'; i++) {
        int val = s[i] - 'a' + 1;
        if (val < 10) {
            numStr[current_idx++] = val + '0';
        } else {
            numStr[current_idx++] = (val / 10) + '0';
            numStr[current_idx++] = (val % 10) + '0';
        }
    }
    numStr[current_idx] = '\0';

    int sum = 0;
    char *currentNumStr = numStr;

    for (int transform = 0; transform < k; transform++) {
        sum = 0;
        for (int i = 0; currentNumStr[i] != '\0'; i++) {
            sum += (currentNumStr[i] - '0');
        }

        if (transform < k - 1) {
            sprintf(numStr, "%d", sum);
            currentNumStr = numStr;
        }
    }

    return sum;
}