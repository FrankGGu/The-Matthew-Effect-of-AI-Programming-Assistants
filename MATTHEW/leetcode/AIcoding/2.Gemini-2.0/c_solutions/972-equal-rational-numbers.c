#include <stdio.h>
#include <stdlib.h>
#include <string.h>

long long gcd(long long a, long long b) {
    if (b == 0) return a;
    return gcd(b, a % b);
}

long long parseRational(const char *s) {
    char *dot = strchr(s, '.');
    if (dot == NULL) {
        return atoll(s);
    }

    char *paren = strchr(s, '(');
    if (paren == NULL) {
        long long integerPart = 0;
        if (s != dot) {
            char integerStr[16];
            strncpy(integerStr, s, dot - s);
            integerStr[dot - s] = '\0';
            integerPart = atoll(integerStr);
        }

        char fractionStr[16];
        strcpy(fractionStr, dot + 1);
        long long fractionPart = atoll(fractionStr);
        int fractionLen = strlen(fractionStr);

        long long num = integerPart * pow(10, fractionLen) + fractionPart;
        long long den = pow(10, fractionLen);
        long long common = gcd(num, den);
        return num * 10000000000000LL / common / (den / common);
    } else {
        long long integerPart = 0;
        if (s != dot) {
            char integerStr[16];
            strncpy(integerStr, s, dot - s);
            integerStr[dot - s] = '\0';
            integerPart = atoll(integerStr);
        }

        char nonRepeatingStr[16];
        strncpy(nonRepeatingStr, dot + 1, paren - dot - 1);
        nonRepeatingStr[paren - dot - 1] = '\0';
        long long nonRepeatingPart = 0;
        int nonRepeatingLen = 0;
        if(strlen(nonRepeatingStr) > 0){
            nonRepeatingPart = atoll(nonRepeatingStr);
            nonRepeatingLen = strlen(nonRepeatingStr);
        }

        char repeatingStr[16];
        strncpy(repeatingStr, paren + 1, strlen(paren + 1) - 1);
        repeatingStr[strlen(paren + 1) - 1] = '\0';
        long long repeatingPart = atoll(repeatingStr);
        int repeatingLen = strlen(repeatingStr);

        long long num = integerPart * pow(10, nonRepeatingLen + repeatingLen) + nonRepeatingPart * pow(10, repeatingLen) + repeatingPart - (integerPart * pow(10, nonRepeatingLen) + nonRepeatingPart);
        long long den = (pow(10, nonRepeatingLen + repeatingLen) - pow(10, nonRepeatingLen));

        long long common = gcd(num, den);
        return num * 10000000000000LL / common / (den / common);
    }
}

bool isRationalEqual(char * s, char * t){
    return parseRational(s) == parseRational(t);
}