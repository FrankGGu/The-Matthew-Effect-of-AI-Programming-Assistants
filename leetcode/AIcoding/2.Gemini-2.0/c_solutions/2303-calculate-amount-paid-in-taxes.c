#include <stdio.h>
#include <stdlib.h>
#include <string.h>

double calculateTax(int** brackets, int bracketsSize, int* bracketsColSize, int income) {
    double tax = 0.0;
    int prev = 0;
    for (int i = 0; i < bracketsSize; i++) {
        int upper = brackets[i][0];
        int percent = brackets[i][1];
        int taxable = (income > upper) ? upper - prev : (income > prev) ? income - prev : 0;
        tax += (double)taxable * percent / 100.0;
        prev = upper;
        if (income <= upper) {
            break;
        }
    }
    return tax;
}