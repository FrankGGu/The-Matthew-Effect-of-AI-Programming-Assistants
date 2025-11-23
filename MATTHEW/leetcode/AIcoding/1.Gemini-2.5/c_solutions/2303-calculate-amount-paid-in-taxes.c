#include <stdlib.h>

static inline int min(int a, int b) {
    return (a < b) ? a : b;
}

double calculateTax(int** brackets, int bracketsSize, int* bracketsColSize, int income) {
    double totalTax = 0.0;
    int prevUpper = 0;

    for (int i = 0; i < bracketsSize; i++) {
        int currentUpper = brackets[i][0];
        int percent = brackets[i][1];

        int taxableAmountInBracketRange = currentUpper - prevUpper;
        int amountToTaxFromIncome = min(income, taxableAmountInBracketRange);

        if (amountToTaxFromIncome > 0) {
            totalTax += (double)amountToTaxFromIncome * (double)percent / 100.0;
            income -= amountToTaxFromIncome;
        }

        prevUpper = currentUpper;

        if (income <= 0) {
            break;
        }
    }

    return totalTax;
}