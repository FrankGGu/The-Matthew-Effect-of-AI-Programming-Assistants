import java.util.HashMap;
import java.util.Map;
import java.util.Stack;

public class Solution {
    public String evaluate(String expression) {
        return evaluateExpression(expression, new HashMap<>());
    }

    private String evaluateExpression(String expr, Map<String, String> variables) {
        if (expr.charAt(0) != '(') {
            if (Character.isDigit(expr.charAt(0)) || expr.charAt(0) == '-') {
                return expr;
            }
            return variables.get(expr);
        }

        Stack<String> stack = new Stack<>();
        int n = expr.length();
        StringBuilder sb = new StringBuilder();
        for (int i = 1; i < n - 1; i++) {
            if (expr.charAt(i) == ' ') {
                continue;
            }

            if (expr.charAt(i) == '(') {
                int j = i, count = 1;
                while (count > 0) {
                    j++;
                    if (expr.charAt(j) == '(') count++;
                    if (expr.charAt(j) == ')') count--;
                }
                stack.push(evaluateExpression(expr.substring(i, j + 1), variables));
                i = j;
            } else {
                int j = i;
                while (j < n - 1 && expr.charAt(j) != ' ') {
                    j++;
                }
                String token = expr.substring(i, j);
                stack.push(token);
                i = j - 1;
            }
        }

        String command = stack.pop();
        if (command.equals("let")) {
            Map<String, String> newVars = new HashMap<>(variables);
            while (!stack.isEmpty()) {
                String var = stack.pop();
                String value = stack.pop();
                newVars.put(var, evaluateExpression(value, newVars));
            }
            return "";
        } else if (command.equals("add")) {
            int a = Integer.parseInt(evaluateExpression(stack.pop(), variables));
            int b = Integer.parseInt(evaluateExpression(stack.pop(), variables));
            return String.valueOf(a + b);
        } else if (command.equals("mult")) {
            int a = Integer.parseInt(evaluateExpression(stack.pop(), variables));
            int b = Integer.parseInt(evaluateExpression(stack.pop(), variables));
            return String.valueOf(a * b);
        }
        return "";
    }
}