typedef struct {
    long long numerator;
    long long denominator;
} Fraction;

Fraction fractionAddition(char *expression) {
    long long num = 0, denom = 1, sign = 1;
    int i = 0, n = strlen(expression);

    while (i < n) {
        if (expression[i] == '+' || expression[i] == '-') {
            sign = (expression[i] == '+') ? 1 : -1;
            i++;
        }

        long long curr_num = 0, curr_denom = 0;

        while (i < n && isdigit(expression[i])) {
            curr_num = curr_num * 10 + (expression[i] - '0');
            i++;
        }

        if (i < n && expression[i] == '/') {
            i++;
            while (i < n && isdigit(expression[i])) {
                curr_denom = curr_denom * 10 + (expression[i] - '0');
                i++;
            }
        } else {
            curr_denom = 1;
        }

        num = num * curr_denom + sign * curr_num * denom;
        denom *= curr_denom;

        i++;
    }

    long long gcd = __gcd(num, denom);
    Fraction result;
    result.numerator = num / gcd;
    result.denominator = denom / gcd;
    return result;
}

long long __gcd(long long a, long long b) {
    while (b) {
        long long temp = b;
        b = a % b;
        a = temp;
    }
    return a;
}