import java.util.*;

class Solution {
    public String countOfAtoms(String formula) {
        Stack<Map<String, Integer>> stack = new Stack<>();
        stack.push(new TreeMap<>());

        int n = formula.length();
        int i = 0;
        while (i < n) {
            char c = formula.charAt(i);
            if (c == '(') {
                stack.push(new TreeMap<>());
                i++;
            } else if (c == ')') {
                Map<String, Integer> top = stack.pop();
                i++;
                int start = i;
                while (i < n && Character.isDigit(formula.charAt(i))) {
                    i++;
                }
                int multiplicity = start < i ? Integer.parseInt(formula.substring(start, i)) : 1;
                for (String atom : top.keySet()) {
                    int count = top.get(atom);
                    stack.peek().put(atom, stack.peek().getOrDefault(atom, 0) + count * multiplicity);
                }
            } else {
                int start = i++;
                while (i < n && Character.isLowerCase(formula.charAt(i))) {
                    i++;
                }
                String atom = formula.substring(start, i);
                start = i;
                while (i < n && Character.isDigit(formula.charAt(i))) {
                    i++;
                }
                int count = start < i ? Integer.parseInt(formula.substring(start, i)) : 1;
                stack.peek().put(atom, stack.peek().getOrDefault(atom, 0) + count);
            }
        }

        StringBuilder result = new StringBuilder();
        for (String atom : stack.peek().keySet()) {
            result.append(atom);
            int count = stack.peek().get(atom);
            if (count > 1) {
                result.append(count);
            }
        }
        return result.toString();
    }
}