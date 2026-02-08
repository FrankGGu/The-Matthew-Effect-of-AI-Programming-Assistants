class Solution {
    public int scoreOfStudents(String s, int[] answers) {
        int correct = calculate(s);
        Set<Integer> possible = computeAllPossible(s);
        int res = 0;
        for (int a : answers) {
            if (a == correct) {
                res += 5;
            } else if (possible.contains(a)) {
                res += 2;
            }
        }
        return res;
    }

    private int calculate(String s) {
        Stack<Integer> stack = new Stack<>();
        int num = 0;
        char op = '+';
        for (int i = 0; i < s.length(); i++) {
            char c = s.charAt(i);
            if (Character.isDigit(c)) {
                num = num * 10 + (c - '0');
            }
            if (!Character.isDigit(c) || i == s.length() - 1) {
                if (op == '+') {
                    stack.push(num);
                } else if (op == '*') {
                    stack.push(stack.pop() * num);
                }
                op = c;
                num = 0;
            }
        }
        int res = 0;
        while (!stack.isEmpty()) {
            res += stack.pop();
        }
        return res;
    }

    private Set<Integer> computeAllPossible(String s) {
        Map<String, Set<Integer>> memo = new HashMap<>();
        return dfs(s, memo);
    }

    private Set<Integer> dfs(String s, Map<String, Set<Integer>> memo) {
        if (memo.containsKey(s)) {
            return memo.get(s);
        }
        Set<Integer> res = new HashSet<>();
        boolean isNumber = true;
        for (char c : s.toCharArray()) {
            if (!Character.isDigit(c)) {
                isNumber = false;
                break;
            }
        }
        if (isNumber) {
            res.add(Integer.parseInt(s));
            memo.put(s, res);
            return res;
        }
        for (int i = 0; i < s.length(); i++) {
            char c = s.charAt(i);
            if (c == '+' || c == '*') {
                Set<Integer> left = dfs(s.substring(0, i), memo);
                Set<Integer> right = dfs(s.substring(i + 1), memo);
                for (int l : left) {
                    for (int r : right) {
                        int val = c == '+' ? l + r : l * r;
                        if (val <= 1000) {
                            res.add(val);
                        }
                    }
                }
            }
        }
        memo.put(s, res);
        return res;
    }
}