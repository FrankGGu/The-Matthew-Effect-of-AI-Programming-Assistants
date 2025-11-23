import java.util.Stack;

class Solution {
    public int clumsy(int N) {
        Stack<Integer> stack = new Stack<>();
        stack.push(N);

        int currentOpIndex = 0; // 0: *, 1: /, 2: +, 3: -

        for (int i = N - 1; i >= 1; i--) {
            if (currentOpIndex % 4 == 0) { // Multiplication
                stack.push(stack.pop() * i);
            } else if (currentOpIndex % 4 == 1) { // Division
                stack.push(stack.pop() / i);
            } else if (currentOpIndex % 4 == 2) { // Addition
                stack.push(i);
            } else { // Subtraction
                stack.push(-i);
            }
            currentOpIndex++;
        }

        int sum = 0;
        while (!stack.isEmpty()) {
            sum += stack.pop();
        }

        return sum;
    }
}