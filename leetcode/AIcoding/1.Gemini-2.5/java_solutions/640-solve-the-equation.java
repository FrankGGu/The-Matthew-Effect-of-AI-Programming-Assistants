class Solution {
    public String solveEquation(String equation) {
        String[] parts = equation.split("=");
        int[] lhs = evaluate(parts[0]);
        int[] rhs = evaluate(parts[1]);

        int xCoeff = lhs[0] - rhs[0];
        int constantSum = rhs[1] - lhs[1];

        if (xCoeff == 0) {
            if (constantSum == 0) {
                return "Infinite solutions";
            } else {
                return "No solution";
            }
        } else {
            return "x=" + (constantSum / xCoeff);
        }
    }

    private int[] evaluate(String s) {
        int xCoeff = 0;
        int constantSum = 0;

        // Prepend '+' if the string doesn't start with '-' to ensure all terms have an explicit sign
        if (s.charAt(0) != '-') {
            s = "+" + s;
        }

        // Replace all '-' with '+-' to easily split terms by '+'
        s = s.replace("-", "+-");

        // Split by '+' to get individual terms
        String[] terms = s.split("\\+");

        for (String term : terms) {
            if (term.isEmpty()) {
                continue; // Skip empty strings that might result from splitting
            }

            if (term.contains("x")) {
                String coeffStr = term.substring(0, term.length() - 1);
                if (coeffStr.isEmpty()) { // "x"
                    xCoeff += 1;
                } else if (coeffStr.equals("-")) { // "-x"
                    xCoeff -= 1;
                } else { // "Cx" or "-Cx"
                    xCoeff += Integer.parseInt(coeffStr);
                }
            } else { // Constant term
                constantSum += Integer.parseInt(term);
            }
        }

        return new int[]{xCoeff, constantSum};
    }
}