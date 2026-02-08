#define MAX_TAX_BRACKETS 100

double calculateTax(int** brackets, int size, double income) {
    double tax = 0.0;
    double previousBracketLimit = 0.0;

    for (int i = 0; i < size; i++) {
        double currentBracketLimit = brackets[i][0];
        double currentBracketRate = brackets[i][1] / 100.0;

        if (income > currentBracketLimit) {
            tax += (currentBracketLimit - previousBracketLimit) * currentBracketRate;
            previousBracketLimit = currentBracketLimit;
        } else {
            tax += (income - previousBracketLimit) * currentBracketRate;
            break;
        }
    }

    return tax;
}