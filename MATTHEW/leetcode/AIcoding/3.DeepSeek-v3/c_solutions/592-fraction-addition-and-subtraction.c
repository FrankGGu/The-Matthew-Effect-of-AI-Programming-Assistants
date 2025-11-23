#include <stdlib.h>
#include <string.h>

int gcd(int a, int b) {
    return b == 0 ? a : gcd(b, a % b);
}

char* fractionAddition(char* expression) {
    int numerator = 0, denominator = 1;
    int i = 0, n = strlen(expression);

    while (i < n) {
        int sign = 1;
        if (expression[i] == '+' || expression[i] == '-') {
            if (expression[i] == '-') sign = -1;
            i++;
        }

        int num = 0;
        while (i < n && expression[i] >= '0' && expression[i] <= '9') {
            num = num * 10 + (expression[i] - '0');
            i++;
        }
        num *= sign;

        i++; // skip '/'

        int den = 0;
        while (i < n && expression[i] >= '0' && expression[i] <= '9') {
            den = den * 10 + (expression[i] - '0');
            i++;
        }

        numerator = numerator * den + num * denominator;
        denominator *= den;

        int g = gcd(abs(numerator), denominator);
        numerator /= g;
        denominator /= g;
    }

    char* result = (char*)malloc(20 * sizeof(char));
    sprintf(result, "%d/%d", numerator, denominator);
    return result;
}