class Solution {
    public String solveEquation(String equation) {
        String[] sides = equation.split("=");
        int[] left = parseSide(sides[0]);
        int[] right = parseSide(sides[1]);

        int a = left[0] - right[0];
        int b = right[1] - left[1];

        if (a == 0) {
            return b == 0 ? "Infinite solutions" : "No solution";
        }

        return "x=" + (b / a);
    }

    private int[] parseSide(String side) {
        int a = 0, b = 0, sign = 1, n = side.length();
        for (int i = 0; i < n; i++) {
            char ch = side.charAt(i);
            if (ch == '+' || ch == '-') {
                sign = (ch == '+') ? 1 : -1;
            } else if (Character.isDigit(ch)) {
                int num = ch - '0';
                while (i + 1 < n && Character.isDigit(side.charAt(i + 1))) {
                    num = num * 10 + (side.charAt(++i) - '0');
                }
                if (i + 1 < n && side.charAt(i + 1) == 'x') {
                    a += sign * (num == 0 ? 1 : num);
                    i++;
                } else {
                    b += sign * num;
                }
            } else if (ch == 'x') {
                a += sign * 1;
            }
        }
        return new int[]{a, b};
    }
}