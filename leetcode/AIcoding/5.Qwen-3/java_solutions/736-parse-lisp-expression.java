public class Solution {

import java.util.*;

public class Solution {
    public int evaluate(String expression) {
        return eval(expression, new HashMap<>(), new ArrayList<>());
    }

    private int eval(String expr, Map<String, Integer> env, List<String> tokens) {
        if (expr.charAt(0) == '(') {
            expr = expr.substring(1, expr.length() - 1);
        }
        String[] parts = expr.split("\\s+", 2);
        if (parts[0].equals("let")) {
            Map<String, Integer> newEnv = new HashMap<>(env);
            int i = 1;
            while (i < tokens.size()) {
                String token = tokens.get(i);
                if (token.equals(")")) {
                    break;
                }
                if (token.equals("let")) {
                    i++;
                    continue;
                }
                if (token.charAt(0) == '(') {
                    int value = eval(token, newEnv, tokens);
                    newEnv.put(tokens.get(i - 1), value);
                    i += 2;
                } else {
                    newEnv.put(tokens.get(i), eval(tokens.get(i + 1), newEnv, tokens));
                    i += 2;
                }
            }
            return eval(expr.substring(parts[0].length() + 1), newEnv, tokens);
        } else if (parts[0].equals("add")) {
            int a = eval(parts[1], env, tokens);
            int b = eval(expr.substring(parts[0].length() + 1), env, tokens);
            return a + b;
        } else if (parts[0].equals("mult")) {
            int a = eval(parts[1], env, tokens);
            int b = eval(expr.substring(parts[0].length() + 1), env, tokens);
            return a * b;
        } else if (Character.isLetter(parts[0].charAt(0))) {
            return env.get(parts[0]);
        } else {
            return Integer.parseInt(parts[0]);
        }
    }
}
}