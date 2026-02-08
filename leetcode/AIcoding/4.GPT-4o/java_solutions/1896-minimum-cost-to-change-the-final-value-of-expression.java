class Solution {
    public int minimizeCost(String expression) {
        int n = expression.length();
        int[][] dpTrue = new int[n][n];
        int[][] dpFalse = new int[n][n];

        for (int i = 0; i < n; i++) {
            if (expression.charAt(i) == '0') {
                dpTrue[i][i] = Integer.MAX_VALUE;
                dpFalse[i][i] = 0;
            } else if (expression.charAt(i) == '1') {
                dpTrue[i][i] = 0;
                dpFalse[i][i] = Integer.MAX_VALUE;
            }
        }

        for (int length = 3; length <= n; length += 2) {
            for (int i = 0; i + length - 1 < n; i += 2) {
                int j = i + length - 1;
                dpTrue[i][j] = Integer.MAX_VALUE;
                dpFalse[i][j] = Integer.MAX_VALUE;

                for (int k = i + 1; k < j; k += 2) {
                    char operator = expression.charAt(k);
                    int leftTrue = dpTrue[i][k - 1];
                    int leftFalse = dpFalse[i][k - 1];
                    int rightTrue = dpTrue[k + 1][j];
                    int rightFalse = dpFalse[k + 1][j];

                    if (operator == '&') {
                        dpTrue[i][j] = Math.min(dpTrue[i][j], leftTrue + rightTrue);
                        dpFalse[i][j] = Math.min(dpFalse[i][j], 
                            Math.min(leftTrue + rightFalse, 
                                     Math.min(leftFalse + rightTrue, 
                                              leftFalse + rightFalse)));
                    } else if (operator == '|') {
                        dpTrue[i][j] = Math.min(dpTrue[i][j], 
                            Math.min(leftTrue + rightTrue, 
                                     Math.min(leftTrue + rightFalse, 
                                              leftFalse + rightTrue)));
                        dpFalse[i][j] = Math.min(dpFalse[i][j], leftFalse + rightFalse);
                    } else if (operator == '^') {
                        dpTrue[i][j] = Math.min(dpTrue[i][j], 
                            Math.min(leftTrue + rightFalse, 
                                     leftFalse + rightTrue));
                        dpFalse[i][j] = Math.min(dpFalse[i][j], 
                            Math.min(leftTrue + rightTrue, 
                                     leftFalse + rightFalse));
                    }
                }
            }
        }

        return dpFalse[0][n - 1] == Integer.MAX_VALUE ? -1 : dpFalse[0][n - 1];
    }
}