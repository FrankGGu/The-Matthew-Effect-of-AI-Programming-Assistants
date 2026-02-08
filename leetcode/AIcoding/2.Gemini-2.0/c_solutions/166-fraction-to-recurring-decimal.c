#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char *fractionToDecimal(int numerator, int denominator) {
    if (numerator == 0) {
        return "0";
    }

    char *result = (char *)malloc(4096 * sizeof(char));
    int index = 0;

    if ((numerator < 0) ^ (denominator < 0)) {
        result[index++] = '-';
    }

    long long num = numerator < 0 ? -(long long)numerator : (long long)numerator;
    long long den = denominator < 0 ? -(long long)denominator : (long long)denominator;

    long long integerPart = num / den;
    sprintf(result + index, "%lld", integerPart);
    index += snprintf(NULL, 0, "%lld", integerPart);

    num %= den;
    if (num == 0) {
        return result;
    }

    result[index++] = '.';

    int fractionIndex = index;
    int *remainderIndexMap = (int *)malloc(4096 * sizeof(int));
    memset(remainderIndexMap, -1, 4096 * sizeof(int));

    while (num != 0) {
        if (remainderIndexMap[num] != -1) {
            int insertIndex = remainderIndexMap[num];
            char *recurringPart = (char *)malloc(4096 * sizeof(char));
            strncpy(recurringPart, result + insertIndex, index - insertIndex);
            recurringPart[index - insertIndex] = '\0';

            char *temp = (char *)malloc(4096 * sizeof(char));
            strncpy(temp, result, insertIndex);
            temp[insertIndex] = '\0';

            sprintf(result, "%s(%s)", temp, recurringPart);
            free(temp);
            free(recurringPart);
            return result;
        }

        remainderIndexMap[num] = index;
        num *= 10;
        long long digit = num / den;
        result[index++] = digit + '0';
        num %= den;
    }

    return result;
}