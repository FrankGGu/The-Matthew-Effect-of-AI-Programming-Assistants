class Solution {
    public String solveEquation(String equation) {
        int[] left = evaluate(equation.substring(0, equation.indexOf('=')));
        int[] right = evaluate(equation.substring(equation.indexOf('=') + 1));

        int xCoeff = left[0] - right[0];
        int constant = right[1] - left[1];

        if (xCoeff == 0) {
            if (constant == 0) {
                return "Infinite solutions";
            } else {
                return "No solution";
            }
        } else {
            return "x=" + (constant / xCoeff);
        }
    }

    private int[] evaluate(String s) {
        int coeff = 0;
        int constant = 0;
        int sign = 1;
        int num = 0;

        for (int i = 0; i < s.length(); i++) {
            char c = s.charAt(i);
            if (Character.isDigit(c)) {
                num = num * 10 + (c - '0');
            } else if (c == 'x') {
                if (num == 0) {
                    if (i == 0 || s.charAt(i - 1) == '+' || s.charAt(i - 1) == '-')
                        coeff += sign * 1;
                    else
                        coeff += sign * num;
                }
                else
                    coeff += sign * num;
                num = 0;
            } else if (c == '+') {
                constant += sign * num;
                sign = 1;
                num = 0;
            } else if (c == '-') {
                constant += sign * num;
                sign = -1;
                num = 0;
            }
        }

        constant += sign * num;
        return new int[]{coeff, constant};
    }
}