#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>

typedef struct {
    int numerator;
    int denominator;
} Fraction;

int gcd(int a, int b) {
    while (b != 0) {
        int temp = b;
        b = a % b;
        a = temp;
    }
    return a;
}

Fraction add(Fraction f1, Fraction f2) {
    int numerator = f1.numerator * f2.denominator + f2.numerator * f1.denominator;
    int denominator = f1.denominator * f2.denominator;
    int g = gcd(numerator, denominator);
    return (Fraction){numerator / g, denominator / g};
}

char* fractionAddition(char* expression) {
    int len = strlen(expression);
    char* result = (char*)malloc(100 * sizeof(char));
    int i = 0;
    int sign = 1;
    int num = 0;
    int den = 0;
    Fraction total = {0, 1};

    while (i < len) {
        if (expression[i] == '-') {
            sign = -1;
            i++;
        } else if (expression[i] == '+') {
            sign = 1;
            i++;
        }

        num = 0;
        while (i < len && expression[i] != '/' && expression[i] != '+' && expression[i] != '-') {
            num = num * 10 + (expression[i] - '0');
            i++;
        }

        if (expression[i] == '/') {
            i++;
            den = 0;
            while (i < len && expression[i] != '+' && expression[i] != '-') {
                den = den * 10 + (expression[i] - '0');
                i++;
            }
        } else {
            den = 1;
        }

        Fraction f = {sign * num, den};
        total = add(total, f);
        sign = 1;
    }

    sprintf(result, "%d/%d", total.numerator, total.denominator);
    return result;
}