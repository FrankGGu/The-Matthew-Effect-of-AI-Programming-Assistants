public class Solution {
    public String solveEquation(String equation) {
        int[] left = parseEquation(equation.split("=")[0]);
        int[] right = parseEquation(equation.split("=")[1]);

        int xCoeff = left[0] - right[0];
        int constTerm = right[1] - left[1];

        if (xCoeff == 0 && constTerm == 0) {
            return "Infinite solutions";
        } else if (xCoeff == 0) {
            return "No solution";
        } else {
            return "x=" + (constTerm / xCoeff);
        }
    }

    private int[] parseEquation(String s) {
        int[] result = new int[2]; // [x coefficient, constant term]
        int i = 0;
        int n = s.length();
        int sign = 1;

        while (i < n) {
            if (s.charAt(i) == '+') {
                sign = 1;
                i++;
            } else if (s.charAt(i) == '-') {
                sign = -1;
                i++;
            }

            int num = 0;
            boolean isNumber = false;
            while (i < n && Character.isDigit(s.charAt(i))) {
                num = num * 10 + (s.charAt(i) - '0');
                i++;
                isNumber = true;
            }

            if (i < n && s.charAt(i) == 'x') {
                result[0] += sign * (isNumber ? num : 1);
                i++;
            } else {
                result[1] += sign * num;
            }
        }

        return result;
    }
}