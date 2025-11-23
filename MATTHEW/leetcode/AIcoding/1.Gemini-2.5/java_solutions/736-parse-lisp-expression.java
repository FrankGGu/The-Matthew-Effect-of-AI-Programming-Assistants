import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

class Solution {
    private List<Map<String, Integer>> scopeStack;

    public int evaluate(String expression) {
        scopeStack = new ArrayList<>();
        scopeStack.add(new HashMap<>()); // Global scope

        return eval(expression);
    }

    private int eval(String expression) {
        if (expression.charAt(0) == '-' || Character.isDigit(expression.charAt(0))) {
            return Integer.parseInt(expression);
        }

        if (expression.charAt(0) != '(') {
            return lookupVariable(expression);
        }

        String innerExpr = expression.substring(1, expression.length() - 1);

        int firstSpace = innerExpr.indexOf(' ');
        String command = (firstSpace == -1) ? innerExpr : innerExpr.substring(0, firstSpace);

        if (command.equals("let")) {
            scopeStack.add(new HashMap<>());
            List<String> tokens = parseTokens(innerExpr.substring(4)); // Skip "let "
            int result = 0;
            for (int i = 0; i < tokens.size(); i += 2) {
                if (i == tokens.size() - 1) {
                    result = eval(tokens.get(i));
                } else {
                    String varName = tokens.get(i);
                    String varValueExpr = tokens.get(i + 1);
                    int varValue = eval(varValueExpr);
                    scopeStack.get(scopeStack.size() - 1).put(varName, varValue);
                }
            }
            scopeStack.remove(scopeStack.size() - 1);
            return result;
        } else if (command.equals("add")) {
            List<String> tokens = parseTokens(innerExpr.substring(4)); // Skip "add "
            int val1 = eval(tokens.get(0));
            int val2 = eval(tokens.get(1));
            return val1 + val2;
        } else if (command.equals("mult")) {
            List<String> tokens = parseTokens(innerExpr.substring(5)); // Skip "mult "
            int val1 = eval(tokens.get(0));
            int val2 = eval(tokens.get(1));
            return val1 * val2;
        }
        return 0; // Should not be reached for valid input
    }

    private int lookupVariable(String varName) {
        for (int i = scopeStack.size() - 1; i >= 0; i--) {
            if (scopeStack.get(i).containsKey(varName)) {
                return scopeStack.get(i).get(varName);
            }
        }
        return 0; // Should not be reached for valid input, variable must exist
    }

    private List<String> parseTokens(String s) {
        List<String> tokens = new ArrayList<>();
        int balance = 0;
        int start = 0;
        for (int i = 0; i < s.length(); i++) {
            char c = s.charAt(i);
            if (c == '(') {
                balance++;
            } else if (c == ')') {
                balance--;
            } else if (c == ' ' && balance == 0) {
                tokens.add(s.substring(start, i));
                start = i + 1;
            }
        }
        tokens.add(s.substring(start));
        return tokens;
    }
}