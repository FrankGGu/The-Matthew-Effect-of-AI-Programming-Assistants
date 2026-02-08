class Solution {
    public int calculate(String s) {
        int n = s.length();
        int currentNum = 0;
        char operation = '+';
        Stack<Integer> stack = new Stack<>();

        for (int i = 0; i < n; i++) {
            char c = s.charAt(i);
            if (Character.isDigit(c)) {
                currentNum = currentNum * 10 + (c - '0');
            }
            if (!Character.isDigit(c) && c != ' ' || i == n - 1) {
                if (operation == '+') {
                    stack.push(currentNum);
                } else if (operation == '-') {
                    stack.push(-currentNum);
                } else if (operation == '*') {
                    stack.push(stack.pop() * currentNum);
                } else if (operation == '/') {
                    stack.push(stack.pop() / currentNum);
                }
                operation = c;
                currentNum = 0;
            }
        }

        int result = 0;
        while (!stack.isEmpty()) {
            result += stack.pop();
        }

        return result;
    }
}