import java.util.ArrayDeque;
import java.util.Deque;

class Solution {

    private int precedence(char op) {
        if (op == '&') return 2;
        if (op == '|') return 1;
        return 0; // For '('
    }

    private int[] calculate(int[] res1, char op, int[] res2) {
        int c1_0 = res1[0], c1_1 = res1[1];
        int c2_0 = res2[0], c2_1 = res2[1];

        // Costs if operator is '&'
        int and_0 = Math.min(c1_0, c2_0);
        int and_1 = c1_1 + c2_1;

        // Costs if operator is '|'
        int or_0 = c1_0 + c2_0;
        int or_1 = Math.min(c1_1, c2_1);

        int final_0, final_1;

        if (op == '&') {
            final_0 = Math.min(and_0, 1 + or_0);
            final_1 = Math.min(and_1, 1 + or_1);
        } else { // op == '|'
            final_0 = Math.min(or_0, 1 + and_0);
            final_1 = Math.min(or_1, 1 + and_1);
        }
        return new int[]{final_0, final_1};
    }

    public int minCostToChangeFinalValue(String expression) {
        Deque<int[]> operandStack = new ArrayDeque<>();
        Deque<Character> operatorStack = new ArrayDeque<>();

        for (char ch : expression.toCharArray()) {
            if (ch == '0') {
                operandStack.push(new int[]{0, 1});
            } else if (ch == '1') {
                operandStack.push(new int[]{1, 0});
            } else if (ch == '(') {
                operatorStack.push(ch);
            } else if (ch == ')') {
                while (operatorStack.peek() != '(') {
                    char op = operatorStack.pop();
                    int[] res2 = operandStack.pop();
                    int[] res1 = operandStack.pop();
                    operandStack.push(calculate(res1, op, res2));
                }
                operatorStack.pop(); // Pop '('
            } else { // ch is '&' or '|'
                while (!operatorStack.isEmpty() && operatorStack.peek() != '(' &&
                       precedence(operatorStack.peek()) >= precedence(ch)) {
                    char op = operatorStack.pop();
                    int[] res2 = operandStack.pop();
                    int[] res1 = operandStack.pop();
                    operandStack.push(calculate(res1, op, res2));
                }
                operatorStack.push(ch);
            }
        }

        while (!operatorStack.isEmpty()) {
            char op = operatorStack.pop();
            int[] res2 = operandStack.pop();
            int[] res1 = operandStack.pop();
            operandStack.push(calculate(res1, op, res2));
        }

        int[] finalResult = operandStack.pop();
        return Math.min(finalResult[0], finalResult[1]);
    }
}