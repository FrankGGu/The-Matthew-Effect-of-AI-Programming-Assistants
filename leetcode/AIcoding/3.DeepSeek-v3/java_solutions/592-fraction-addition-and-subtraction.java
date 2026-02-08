class Solution {
    public String fractionAddition(String expression) {
        List<Character> signs = new ArrayList<>();
        if (expression.charAt(0) != '-') {
            signs.add('+');
        }
        for (int i = 0; i < expression.length(); i++) {
            if (expression.charAt(i) == '+' || expression.charAt(i) == '-') {
                signs.add(expression.charAt(i));
            }
        }
        int numerator = 0, denominator = 1;
        int prevNum = 0, prevDen = 0;
        int i = 0;
        for (int j = 0; j < signs.size(); j++) {
            int k = i;
            while (k < expression.length() && expression.charAt(k) != '/' && expression.charAt(k) != '+' && expression.charAt(k) != '-') {
                k++;
            }
            prevNum = Integer.parseInt(expression.substring(i, k));
            i = k + 1;
            k = i;
            while (k < expression.length() && expression.charAt(k) != '+' && expression.charAt(k) != '-') {
                k++;
            }
            prevDen = Integer.parseInt(expression.substring(i, k));
            i = k;
            if (signs.get(j) == '-') {
                prevNum = -prevNum;
            }
            numerator = numerator * prevDen + prevNum * denominator;
            denominator *= prevDen;
            int gcd = Math.abs(gcd(numerator, denominator));
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