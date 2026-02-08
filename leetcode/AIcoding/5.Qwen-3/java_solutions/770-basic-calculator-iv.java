public class Solution {

import java.util.*;

public class Solution {
    public List<String> parseExpression(String expression) {
        List<String> tokens = new ArrayList<>();
        int i = 0;
        while (i < expression.length()) {
            char c = expression.charAt(i);
            if (c == ' ') {
                i++;
                continue;
            } else if (c == '+' || c == '-' || c == '*' || c == '(' || c == ')') {
                tokens.add(Character.toString(c));
                i++;
            } else if (Character.isDigit(c)) {
                StringBuilder num = new StringBuilder();
                while (i < expression.length() && Character.isDigit(expression.charAt(i))) {
                    num.append(expression.charAt(i));
                    i++;
                }
                tokens.add(num.toString());
            } else {
                StringBuilder var = new StringBuilder();
                while (i < expression.length() && Character.isLetter(expression.charAt(i))) {
                    var.append(expression.charAt(i));
                    i++;
                }
                tokens.add(var.toString());
            }
        }
        return tokens;
    }

    public List<String> basicCalculatorIV(String expression, String[] evalvars, int[] evalints) {
        Map<String, Integer> map = new HashMap<>();
        for (int i = 0; i < evalvars.length; i++) {
            map.put(evalvars[i], evalints[i]);
        }
        List<String> tokens = parseExpression(expression);
        Deque<Object> stack = new ArrayDeque<>();
        Deque<Character> opStack = new ArrayDeque<>();
        int i = 0;
        while (i < tokens.size()) {
            String token = tokens.get(i);
            if (token.equals("(")) {
                opStack.push('(');
                i++;
            } else if (token.equals(")")) {
                while (!opStack.isEmpty() && opStack.peek() != '(') {
                    applyOp(stack, opStack.pop());
                }
                opStack.pop(); // Remove '('
                i++;
            } else if (isOperator(token)) {
                while (!opStack.isEmpty() && precedence(opStack.peek()) >= precedence(token.charAt(0))) {
                    applyOp(stack, opStack.pop());
                }
                opStack.push(token.charAt(0));
                i++;
            } else {
                stack.push(token);
                i++;
            }
        }
        while (!opStack.isEmpty()) {
            applyOp(stack, opStack.pop());
        }
        List<String> result = new ArrayList<>();
        if (stack.peek() instanceof String) {
            result.add((String) stack.peek());
        } else {
            List<Monomial> monomials = (List<Monomial>) stack.peek();
            for (Monomial m : monomials) {
                result.add(m.toString(map));
            }
        }
        Collections.sort(result, (a, b) -> {
            int aDegree = getDegree(a);
            int bDegree = getDegree(b);
            if (aDegree != bDegree) return bDegree - aDegree;
            return a.compareTo(b);
        });
        return result;
    }

    private boolean isOperator(String s) {
        return s.equals("+") || s.equals("-") || s.equals("*");
    }

    private int precedence(char op) {
        return op == '*' ? 2 : 1;
    }

    private void applyOp(Deque<Object> stack, char op) {
        Object right = stack.pop();
        Object left = stack.pop();
        if (left instanceof String && right instanceof String) {
            if (op == '+') {
                stack.push(left + "+" + right);
            } else if (op == '-') {
                stack.push(left + "-" + right);
            } else if (op == '*') {
                stack.push(left + "*" + right);
            }
        } else if (left instanceof List && right instanceof List) {
            List<Monomial> leftMons = (List<Monomial>) left;
            List<Monomial> rightMons = (List<Monomial>) right;
            List<Monomial> result = new ArrayList<>();
            for (Monomial l : leftMons) {
                for (Monomial r : rightMons) {
                    Monomial product = l.multiply(r);
                    result.add(product);
                }
            }
            stack.push(result);
        } else if (left instanceof String && right instanceof List) {
            List<Monomial> rightMons = (List<Monomial>) right;
            List<Monomial> result = new ArrayList<>();
            for (Monomial m : rightMons) {
                String expr = left + "*" + m.toString();
                result.add(new Monomial(expr, m.vars));
            }
            stack.push(result);
        } else if (left instanceof List && right instanceof String) {
            List<Monomial> leftMons = (List<Monomial>) left;
            List<Monomial> result = new ArrayList<>();
            for (Monomial m : leftMons) {
                String expr = m.toString() + "*" + right;
                result.add(new Monomial(expr, m.vars));
            }
            stack.push(result);
        }
    }

    private static class Monomial {
        String expr;
        List<String> vars;

        public Monomial(String expr, List<String> vars) {
            this.expr = expr;
            this.vars = vars;
        }

        public Monomial multiply(Monomial other) {
            List<String> combinedVars = new ArrayList<>(this.vars);
            combinedVars.addAll(other.vars);
            combinedVars.sort(null);
            return new Monomial(this.expr + "*" + other.expr, combinedVars);
        }

        public String toString(Map<String, Integer> map) {
            StringBuilder sb = new StringBuilder();
            if (expr.equals("1")) {
                return "";
            }
            if (expr.equals("0")) {
                return "0";
            }
            List<String> sortedVars = new ArrayList<>(vars);
            Collections.sort(sortedVars);
            for (String var : sortedVars) {
                if (map.containsKey(var)) {
                    sb.append(map.get(var));
                } else {
                    sb.append(var);
                }
                sb.append("*");
            }
            if (sb.length() > 0) {
                sb.setLength(sb.length() - 1);
            }
            if (sb.length() == 0) {
                return expr;
            } else {
                return expr + "*" + sb.toString();
            }
        }
    }

    private int getDegree(String s) {
        int count = 0;
        for (char c : s.toCharArray()) {
            if (c == '*') {
                count++;
            }
        }
        return count;
    }
}
}