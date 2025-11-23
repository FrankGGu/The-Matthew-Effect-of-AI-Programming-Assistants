class Solution {
    public int scoreOfStudents(String s, int[] answers) {
        Set<Integer> correctAnswers = new HashSet<>();
        int correctAnswer = calculate(s);
        correctAnswers.add(correctAnswer);

        Set<Integer>[][] dp = new Set[s.length()][s.length()];
        for (int i = 0; i < s.length(); i += 2) {
            dp[i][i] = new HashSet<>();
            dp[i][i].add(s.charAt(i) - '0');
        }

        for (int len = 3; len <= s.length(); len += 2) {
            for (int i = 0; i <= s.length() - len; i += 2) {
                int j = i + len - 1;
                dp[i][j] = new HashSet<>();
                for (int k = i + 1; k < j; k += 2) {
                    for (int left : dp[i][k - 1]) {
                        for (int right : dp[k + 1][j]) {
                            if (s.charAt(k) == '+') {
                                if (left + right <= 1000) {
                                    dp[i][j].add(left + right);
                                }
                            } else if (s.charAt(k) == '*') {
                                if (left * right <= 1000) {
                                    dp[i][j].add(left * right);
                                }
                            }
                        }
                    }
                }
            }
        }

        int score = 0;
        for (int answer : answers) {
            if (answer == correctAnswer) {
                score += 5;
            } else if (dp[0][s.length() - 1].contains(answer)) {
                score += 2;
            }
        }

        return score;
    }

    private int calculate(String s) {
        Stack<Integer> nums = new Stack<>();
        Stack<Character> ops = new Stack<>();

        for (int i = 0; i < s.length(); i++) {
            char c = s.charAt(i);
            if (Character.isDigit(c)) {
                nums.push(c - '0');
            } else if (c == '+' || c == '*') {
                while (!ops.isEmpty() && precedence(ops.peek()) >= precedence(c)) {
                    evaluate(nums, ops);
                }
                ops.push(c);
            }
        }

        while (!ops.isEmpty()) {
            evaluate(nums, ops);
        }

        return nums.pop();
    }

    private int precedence(char op) {
        if (op == '*') return 2;
        if (op == '+') return 1;
        return 0;
    }

    private void evaluate(Stack<Integer> nums, Stack<Character> ops) {
        int num2 = nums.pop();
        int num1 = nums.pop();
        char op = ops.pop();

        int result = 0;
        if (op == '+') {
            result = num1 + num2;
        } else if (op == '*') {
            result = num1 * num2;
        }
        nums.push(result);
    }
}