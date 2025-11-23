import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Stack;

class Solution {
    public int evaluate(String expression) {
        return eval(expression, new HashMap<>());
    }

    private int eval(String expression, Map<String, Integer> parentScope) {
        if (!expression.startsWith("(")) {
            try {
                return Integer.parseInt(expression);
            } catch (NumberFormatException e) {
                return parentScope.get(expression);
            }
        }

        expression = expression.substring(1, expression.length() - 1);
        String[] tokens = tokenize(expression);

        if (tokens[0].equals("let")) {
            Map<String, Integer> localScope = new HashMap<>(parentScope);
            for (int i = 1; i < tokens.length - 1; i += 2) {
                localScope.put(tokens[i], eval(tokens[i + 1], localScope));
            }
            return eval(tokens[tokens.length - 1], localScope);
        } else if (tokens[0].equals("add")) {
            return eval(tokens[1], parentScope) + eval(tokens[2], parentScope);
        } else { // "mult"
            return eval(tokens[1], parentScope) * eval(tokens[2], parentScope);
        }
    }

    private String[] tokenize(String expression) {
        List<String> tokens = new ArrayList<>();
        StringBuilder sb = new StringBuilder();
        int balance = 0;

        for (int i = 0; i < expression.length(); i++) {
            char c = expression.charAt(i);
            if (c == ' ' && balance == 0) {
                if (sb.length() > 0) {
                    tokens.add(sb.toString());
                    sb = new StringBuilder();
                }
            } else {
                sb.append(c);
                if (c == '(') {
                    balance++;
                } else if (c == ')') {
                    balance--;
                }
            }
        }

        if (sb.length() > 0) {
            tokens.add(sb.toString());
        }

        return tokens.toArray(new String[0]);
    }
}