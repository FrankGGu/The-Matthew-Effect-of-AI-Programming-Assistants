#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char* fractionToDecimal(int numerator, int denominator) {
    if (numerator == 0) {
        return "0";
    }

    char* result = (char*)malloc(1000 * sizeof(char));
    int index = 0;

    if ((numerator < 0) ^ (denominator < 0)) {
        result[index++] = '-';
    }

    long long num = labs((long long)numerator);
    long long den = labs((long long)denominator);

    long long integerPart = num / den;
    num %= den;

    sprintf(result + index, "%lld", integerPart);
    index += strlen(result + index);

    if (num == 0) {
        return result;
    }

    result[index++] = '.';
    num *= 10;

    int map[1000];
    memset(map, -1, sizeof(map));

    while (num > 0) {
        if (map[num] != -1) {
            int pos = map[num];
            memmove(result + pos, result + index, strlen(result + index) + 1);
            result[pos] = '(';
            result[index++] = ')';
            break;
        }
        map[num] = index;
        result[index++] = '0' + num / den;
        num = (num % den) * 10;
    }

    return result;
}