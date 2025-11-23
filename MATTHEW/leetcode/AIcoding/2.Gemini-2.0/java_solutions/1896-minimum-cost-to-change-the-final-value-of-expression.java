import java.util.ArrayList;
import java.util.List;
import java.util.Stack;

class Solution {
    public int minCostToChange(String expression) {
        List<Character> ops = new ArrayList<>();
        List<Integer> nums = new ArrayList<>();
        Stack<Character> opStack = new Stack<>();
        Stack<Pair> numStack = new Stack<>();

        for (char c : expression.toCharArray()) {
            if (c == '(') {
                opStack.push(c);
            } else if (c == ')') {
                while (opStack.peek() != '(') {
                    calculate(numStack, opStack);
                }
                opStack.pop();
            } else if (c == '&' || c == '|') {
                while (!opStack.isEmpty() && precedence(opStack.peek()) >= precedence(c)) {
                    calculate(numStack, opStack);
                }
                opStack.push(c);
            } else {
                numStack.push(new Pair(c - '0', 1));
            }
        }

        while (!opStack.isEmpty()) {
            calculate(numStack, opStack);
        }

        return numStack.peek().cost;
    }

    private void calculate(Stack<Pair> numStack, Stack<Character> opStack) {
        char op = opStack.pop();
        Pair num2 = numStack.pop();
        Pair num1 = numStack.pop();
        int val1 = num1.val;
        int val2 = num2.val;
        int cost1 = num1.cost;
        int cost2 = num2.cost;

        if (op == '&') {
            numStack.push(new Pair(val1 & val2, (val1 == 1 && val2 == 1) ? Math.min(cost1 + 1, cost2 + 1) : 0));
        } else {
            numStack.push(new Pair(val1 | val2, (val1 == 0 && val2 == 0) ? Math.min(cost1 + 1, cost2 + 1) : 0));
        }
    }

    private int precedence(char op) {
        if (op == '(' || op == ')') {
            return 0;
        } else if (op == '|') {
            return 1;
        } else if (op == '&') {
            return 2;
        }
        return -1;
    }

    private static class Pair {
        int val;
        int cost;

        public Pair(int val, int cost) {
            this.val = val;
            this.cost = cost;
        }
    }
}