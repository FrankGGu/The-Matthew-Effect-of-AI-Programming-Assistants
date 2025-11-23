public class Solution {

import java.util.*;

public class Solution {
    public String fractionAddition(String expression) {
        List<int[]> fractions = new ArrayList<>();
        int n = expression.length();
        int i = 0;
        while (i < n) {
            int sign = 1;
            if (expression.charAt(i) == '-') {
                sign = -1;
                i++;
            } else if (expression.charAt(i) == '+') {
                i++;
            }
            int num = 0;
            while (i < n && Character.isDigit(expression.charAt(i))) {
                num = num * 10 + (expression.charAt(i) - '0');
                i++;
            }
            num *= sign;
            int denom = 0;
            i++; // skip '/'
            while (i < n && Character.isDigit(expression.charAt(i))) {
                denom = denom * 10 + (expression.charAt(i) - '0');
                i++;
            }
            fractions.add(new int[]{num, denom});
        }

        int numerator = 0;
        int denominator = 1;

        for (int[] f : fractions) {
            int num = f[0];
            int den = f[1];

            numerator = numerator * den + num * denominator;
            denominator = denominator * den;

            int gcd = gcd(Math.abs(numerator), Math.abs(denominator));
            numerator /= gcd;
            denominator /= gcd;
        }

        return numerator + "/" + denominator;
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
}