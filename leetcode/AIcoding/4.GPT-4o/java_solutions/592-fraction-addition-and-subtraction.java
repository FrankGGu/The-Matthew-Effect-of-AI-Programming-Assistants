import java.util.*;

class Solution {
    public String fractionAddition(String expression) {
        int numerator = 0, denominator = 1;
        int index = 0;
        while (index < expression.length()) {
            int sign = 1;
            if (expression.charAt(index) == '+' || expression.charAt(index) == '-') {
                if (expression.charAt(index) == '-') sign = -1;
                index++;
            }
            int num = 0;
            while (index < expression.length() && Character.isDigit(expression.charAt(index))) {
                num = num * 10 + (expression.charAt(index) - '0');
                index++;
            }
            num *= sign;
            index++; // skip '/'
            int den = 0;
            while (index < expression.length() && Character.isDigit(expression.charAt(index))) {
                den = den * 10 + (expression.charAt(index) - '0');
                index++;
            }
            numerator = numerator * den + num * denominator;
            denominator *= den;
        }
        int gcd = gcd(Math.abs(numerator), denominator);
        return (numerator / gcd) + "/" + (denominator / gcd);
    }

    private int gcd(int a, int b) {
        while (b != 0) {
            int temp = b;
            b = a % b;
            a = temp;
        }
        return a;
    }
}