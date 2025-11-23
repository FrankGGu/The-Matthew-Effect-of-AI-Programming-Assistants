#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char * baseNeg2(int n) {
    if (n == 0) {
        char *result = (char *)malloc(2 * sizeof(char));
        result[0] = '0';
        result[1] = '\0';
        return result;
    }

    char *result = (char *)malloc(32 * sizeof(char));
    int index = 0;

    while (n != 0) {
        int remainder = n % (-2);
        n = n / (-2);

        if (remainder < 0) {
            remainder += 2;
            n += 1;
        }

        result[index++] = remainder + '0';
    }

    result[index] = '\0';

    int i = 0;
    int j = index - 1;
    while (i < j) {
        char temp = result[i];
        result[i] = result[j];
        result[j] = temp;
        i++;
        j--;
    }

    return result;
}