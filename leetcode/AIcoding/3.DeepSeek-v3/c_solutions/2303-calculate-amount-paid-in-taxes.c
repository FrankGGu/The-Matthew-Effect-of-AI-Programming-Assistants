int calculateTax(int** brackets, int bracketsSize, int* bracketsColSize, int income) {
    int tax = 0;
    int prev = 0;

    for (int i = 0; i < bracketsSize && income > 0; i++) {
        int upper = brackets[i][0];
        int percent = brackets[i][1];

        int taxable = (income < upper ? income : upper) - prev;
        if (taxable > 0) {
            tax += taxable * percent;
        }

        prev = upper;
        if (income <= upper) {
            break;
        }
    }

    return tax;
}