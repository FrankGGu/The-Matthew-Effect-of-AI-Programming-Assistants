#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char* fractionToDecimal(int numerator, int denominator) {
    if (numerator == 0) {
        char* result = (char*)malloc(2);
        strcpy(result, "0");
        return result;
    }

    long long num = (long long)numerator;
    long long den = (long long)denominator;

    char* result = (char*)malloc(1000 * sizeof(char));
    int index = 0;

    if ((num < 0 && den > 0) || (num > 0 && den < 0)) {
        result[index++] = '-';
        num = abs(num);
        den = abs(den);
    } else if (num < 0 && den < 0) {
        num = abs(num);
        den = abs(den);
    }

    long long integerPart = num / den;
    num %= den;

    sprintf(result + index, "%lld", integerPart);
    index += strlen(result + index);

    if (num == 0) {
        return result;
    }

    result[index++] = '.';
    int len = index;

    int map[1000000];
    memset(map, -1, sizeof(map));

    while (num != 0) {
        if (map[num] != -1) {
            int pos = map[num];
            for (int i = 0; i < len - pos; i++) {
                result[index++] = result[pos++];
            }
            result[index] = '\0';
            return result;
        }
        map[num] = index;
        num *= 10;
        long long digit = num / den;
        result[index++] = '0' + digit;
        num %= den;
    }

    result[index] = '\0';
    return result;
}