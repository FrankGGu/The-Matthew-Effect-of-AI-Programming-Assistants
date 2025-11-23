class Solution {
    public String fractionAddition(String expression) {
        int resultNum = 0;
        int resultDen = 1;

        int i = 0;
        int n = expression.length();

        while (i < n) {
            int sign = 1;
            if (expression.charAt(i) == '-') {
                sign = -1;
                i++;
            } else if (expression.charAt(i) == '+') {
                i++;
            }

            int currentNum = 0;
            while (i < n && Character.isDigit(expression.charAt(i))) {
                currentNum = currentNum * 10 + (expression.charAt(i) - '0');
                i++;
            }
            currentNum *= sign;

            i++; // Skip '/'

            int currentDen = 0;
            while (i < n && Character.isDigit(expression.charAt(i))) {
                currentDen = currentDen * 10 + (expression.charAt(i) - '0');
                i++;
            }

            resultNum = resultNum * currentDen + currentNum * resultDen;
            resultDen = resultDen * currentDen;

            int commonDivisor = gcd(Math.abs(resultNum), Math.abs(resultDen));
            resultNum /= commonDivisor;
            resultDen /= commonDivisor;
        }

        return resultNum + "/" + resultDen;
    }

    private int gcd(int a, int b) {
        if (b == 0) {
            return a;
        }
        return gcd(b, a % b);
    }
}