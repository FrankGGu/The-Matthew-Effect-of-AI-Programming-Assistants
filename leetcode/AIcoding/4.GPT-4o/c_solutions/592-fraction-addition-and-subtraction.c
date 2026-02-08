#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct Fraction {
    int numerator;
    int denominator;
};

int gcd(int a, int b) {
    while (b) {
        int t = b;
        b = a % b;
        a = t;
    }
    return a;
}

struct Fraction addFractions(struct Fraction f1, struct Fraction f2) {
    struct Fraction result;
    result.numerator = f1.numerator * f2.denominator + f2.numerator * f1.denominator;
    result.denominator = f1.denominator * f2.denominator;
    int g = gcd(abs(result.numerator), abs(result.denominator));
    result.numerator /= g;
    result.denominator /= g;
    return result;
}

char *fractionAddition(char *expression) {
    struct Fraction result = {0, 1};
    char *ptr = expression;
    int sign = 1;

    while (*ptr) {
        if (*ptr == '+' || *ptr == '-') {
            sign = (*ptr == '-') ? -1 : 1;
            ptr++;
        }
        int num = 0;
        while (*ptr >= '0' && *ptr <= '9') {
            num = num * 10 + (*ptr - '0');
            ptr++;
        }
        int denom = 0;
        ptr++; // skip '/'
        while (*ptr >= '0' && *ptr <= '9') {
            denom = denom * 10 + (*ptr - '0');
            ptr++;
        }
        struct Fraction current = {sign * num, denom};
        result = addFractions(result, current);
    }

    char *resultStr = (char *)malloc(20 * sizeof(char));
    sprintf(resultStr, "%d/%d", result.numerator, result.denominator);
    return resultStr;
}