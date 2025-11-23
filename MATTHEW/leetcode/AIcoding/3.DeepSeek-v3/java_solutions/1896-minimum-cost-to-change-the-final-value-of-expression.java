class Solution {
    public int minOperationsToFlip(String expression) {
        int n = expression.length();
        int[] dp = new int[n];
        int[] val = new int[n];
        Deque<Integer> stack = new ArrayDeque<>();
        for (int i = 0; i < n; ++i) {
            char c = expression.charAt(i);
            if (c == '(') {
                stack.push(i);
            } else if (c == ')') {
                int j = stack.pop();
                dp[i] = dp[j];
                val[i] = val[j];
            } else if (c == '0' || c == '1') {
                val[i] = c - '0';
                dp[i] = 1;
            } else {
                int j = stack.peek();
                if (c == '&') {
                    if (val[j] == 1 && val[i - 1] == 1) {
                        val[i] = 1;
                        dp[i] = Math.min(dp[j], dp[i - 1]);
                    } else if (val[j] == 0 || val[i - 1] == 0) {
                        val[i] = 0;
                        if (val[j] == 0 && val[i - 1] == 0) {
                            dp[i] = Math.min(dp[j], dp[i - 1]) + 1;
                        } else {
                            dp[i] = 1;
                        }
                    }
                } else if (c == '|') {
                    if (val[j] == 1 || val[i - 1] == 1) {
                        val[i] = 1;
                        if (val[j] == 1 && val[i - 1] == 1) {
                            dp[i] = Math.min(dp[j], dp[i - 1]) + 1;
                        } else {
                            dp[i] = 1;
                        }
                    } else {
                        val[i] = 0;
                        dp[i] = Math.min(dp[j], dp[i - 1]);
                    }
                }
                stack.pop();
                stack.push(i);
            }
        }
        return dp[n - 1];
    }
}