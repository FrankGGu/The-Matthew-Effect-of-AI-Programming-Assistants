class Solution {
    public String minimizeResult(String expression) {
        int plusIndex = expression.indexOf('+');
        int n = expression.length();
        int minVal = Integer.MAX_VALUE;
        String res = "";
        for (int i = 0; i < plusIndex; i++) {
            for (int j = plusIndex + 1; j < n; j++) {
                int a = Integer.parseInt(expression.substring(0, i == 0 ? 0 : i));
                int b = Integer.parseInt(expression.substring(i, plusIndex));
                int c = Integer.parseInt(expression.substring(plusIndex + 1, j + 1));
                int d = Integer.parseInt(expression.substring(j + 1, n == j + 1 ? j + 1 : n));
                int val = (i == 0 ? 1 : a) * (b + c) * (n == j + 1 ? 1 : d);
                if (val < minVal) {
                    minVal = val;
                    res = (i == 0 ? "" : expression.substring(0, i)) + "(" + expression.substring(i, plusIndex) + "+" + expression.substring(plusIndex + 1, j + 1) + ")" + (n == j + 1 ? "" : expression.substring(j + 1, n));
                }
            }
        }
        return res;
    }
}