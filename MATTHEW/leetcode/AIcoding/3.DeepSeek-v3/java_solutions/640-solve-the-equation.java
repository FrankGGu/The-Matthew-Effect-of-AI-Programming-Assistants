class Solution {
    public String solveEquation(String equation) {
        String[] parts = equation.split("=");
        int[] left = evaluateExpression(parts[0]);
        int[] right = evaluateExpression(parts[1]);

        int xCoeff = left[0] - right[0];
        int constTerm = right[1] - left[1];

        if (xCoeff == 0) {
            if (constTerm == 0) {
                return "Infinite solutions";
            } else {
                return "No solution";
            }
        } else {
            return "x=" + (constTerm / xCoeff);
        }
    }

    private int[] evaluateExpression(String s) {
        int[] res = new int[2]; // res[0] = coefficient of x, res[1] = constant term
        String[] tokens = s.split("(?=[+-])");
        for (String token : tokens) {
            if (token.equals("+x") || token.equals("x")) {
                res[0] += 1;
            } else if (token.equals("-x")) {
                res[0] -= 1;
            } else if (token.contains("x")) {
                res[0] += Integer.parseInt(token.substring(0, token.indexOf("x")));
            } else {
                res[1] += Integer.parseInt(token);
            }
        }
        return res;
    }
}