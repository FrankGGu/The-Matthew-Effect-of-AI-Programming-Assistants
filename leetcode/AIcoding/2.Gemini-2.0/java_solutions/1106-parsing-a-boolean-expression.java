import java.util.ArrayDeque;
import java.util.Deque;
import java.util.HashSet;
import java.util.Set;

class Solution {
    public boolean parseBoolExpr(String expression) {
        Deque<Character> ops = new ArrayDeque<>();
        Deque<Set<Character>> values = new ArrayDeque<>();

        for (char c : expression.toCharArray()) {
            if (c == '(') {
                values.push(new HashSet<>());
            } else if (c == '&' || c == '|' || c == '!') {
                ops.push(c);
            } else if (c == 't' || c == 'f') {
                if (values.isEmpty()) {
                    Set<Character> newSet = new HashSet<>();
                    newSet.add(c);
                    values.push(newSet);
                } else {
                    values.peek().add(c);
                }
            } else if (c == ')') {
                char op = ops.pop();
                Set<Character> currentValues = values.pop();
                boolean result;
                if (op == '&') {
                    result = !currentValues.contains('f');
                } else if (op == '|') {
                    result = currentValues.contains('t');
                } else {
                    result = currentValues.contains('t') ? false : true;
                }

                if (values.isEmpty()) {
                    Set<Character> newSet = new HashSet<>();
                    newSet.add(result ? 't' : 'f');
                    values.push(newSet);
                } else {
                    values.peek().add(result ? 't' : 'f');
                }
            }
        }

        return values.peek().contains('t');
    }
}