class Solution {
    public int scoreOfStudents(String s, int[] answers) {
        int n = s.length();
        Set<Integer>[][] dp = new Set[n][n];
        for (int i = 0; i < n; i += 2) {
            dp[i][i] = new HashSet<>();
            dp[i][i].add(s.charAt(i) - '0');
        }

        for (int len = 3; len <= n; len += 2) {
            for (int i = 0; i <= n - len; i += 2) {
                int j = i + len - 1;
                dp[i][j] = new HashSet<>();
                for (int k = i + 1; k < j; k += 2) {
                    for (int left : dp[i][k - 1]) {
                        for (int right : dp[k + 1][j]) {
                            int res;
                            if (s.charAt(k) == '+') {
                                res = left + right;
                            } else {
                                res = left * right;
                            }
                            if (res <= 1000) {
                                dp[i][j].add(res);
                            }
                        }
                    }
                }
            }
        }

        int correct = eval(s);
        int score = 0;
        for (int answer : answers) {
            if (answer == correct) {
                score += 5;
            } else if (dp[0][n - 1].contains(answer)) {
                score += 2;
            }
        }
        return score;
    }

    private int eval(String s) {
        Stack<Integer> nums = new Stack<>();
        Stack<Character> ops = new Stack<>();

        for (int i = 0; i < s.length(); i++) {
            char c = s.charAt(i);
            if (Character.isDigit(c)) {
                nums.push(c - '0');
            } else if (c == '+') {
                ops.push(c);
            } else if (c == '*') {
                ops.push(c);
            }
        }

        Stack<Integer> newNums = new Stack<>();
        Stack<Character> newOps = new Stack<>();

        while (!ops.isEmpty()) {
            if (ops.peek() == '*') {
                int num2 = nums.pop();
                int num1 = nums.pop();
                nums.push(num1 * num2);
                ops.pop();
            } else {
                newNums.push(nums.pop());
                newOps.push(ops.pop());
            }
        }
        newNums.push(nums.pop());

        nums = new Stack<>();
        ops = new Stack<>();
        while (!newNums.isEmpty()) {
            nums.push(newNums.pop());
        }
        while (!newOps.isEmpty()) {
            ops.push(newOps.pop());
        }

        while (!ops.isEmpty()) {
            int num1 = nums.pop();
            int num2 = nums.pop();
            nums.push(num1 + num2);
            ops.pop();
        }

        return nums.pop();
    }
}