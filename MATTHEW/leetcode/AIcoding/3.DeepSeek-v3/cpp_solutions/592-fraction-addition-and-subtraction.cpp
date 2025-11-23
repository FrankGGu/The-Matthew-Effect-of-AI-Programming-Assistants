class Solution {
public:
    string fractionAddition(string expression) {
        int numerator = 0, denominator = 1;
        int i = 0, n = expression.size();
        while (i < n) {
            int sign = 1;
            if (expression[i] == '-') {
                sign = -1;
                i++;
            } else if (expression[i] == '+') {
                i++;
            }

            int num = 0;
            while (i < n && isdigit(expression[i])) {
                num = num * 10 + (expression[i] - '0');
                i++;
            }
            num *= sign;
            i++; // skip '/'

            int den = 0;
            while (i < n && isdigit(expression[i])) {
                den = den * 10 + (expression[i] - '0');
                i++;
            }

            numerator = numerator * den + num * denominator;
            denominator *= den;
        }

        if (numerator == 0) {
            return "0/1";
        }

        int gcd_val = gcd(abs(numerator), denominator);
        numerator /= gcd_val;
        denominator /= gcd_val;

        return to_string(numerator) + "/" + to_string(denominator);
    }

private:
    int gcd(int a, int b) {
        while (b != 0) {
            int temp = b;
            b = a % b;
            a = temp;
        }
        return a;
    }
};