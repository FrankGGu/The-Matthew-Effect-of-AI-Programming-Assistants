class Solution {
    public String fractionAddition(String expression) {
        int num = 0, den = 1, sign = 1;
        for (int i = 0; i < expression.length(); ) {
            int s = i;
            if (expression.charAt(i) == '+' || expression.charAt(i) == '-') {
                sign = expression.charAt(i) == '+' ? 1 : -1;
                i++;
            }
            int num1 = 0;
            while (i < expression.length() && Character.isDigit(expression.charAt(i))) {
                num1 = num1 * 10 + (expression.charAt(i) - '0');
                i++;
            }
            i++;
            int den1 = 0;
            while (i < expression.length() && Character.isDigit(expression.charAt(i))) {
                den1 = den1 * 10 + (expression.charAt(i) - '0');
                i++;
            }
            num = num * den1 + sign * num1 * den;
            den = den * den1;
        }
        int gcd = gcd(Math.abs(num), den);
        return (num / gcd) + "/" + (den / gcd);
    }

    private int gcd(int a, int b) {
        return b == 0 ? a : gcd(b, a % b);
    }
}