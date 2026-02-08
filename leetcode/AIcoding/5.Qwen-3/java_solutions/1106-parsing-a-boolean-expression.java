public class Solution {

import java.util.*;

public class Solution {
    public boolean parseBoolExpr(String expression) {
        Stack<Character> stack = new Stack<>();
        for (char c : expression.toCharArray()) {
            if (c == '(' || c == ',' || c == ' ') {
                continue;
            } else if (c == 't' || c == 'f' || c == '!' || c == '&' || c == '|') {
                stack.push(c);
            } else if (c == ')') {
                char op = stack.pop();
                boolean result = false;
                boolean first = true;
                while (stack.peek() != '(') {
                    char val = stack.pop();
                    if (val == 't') {
                        if (op == '!') {
                            result = false;
                        } else if (op == '&') {
                            result = result && true;
                        } else if (op == '|') {
                            result = result || true;
                        }
                    } else if (val == 'f') {
                        if (op == '!') {
                            result = true;
                        } else if (op == '&') {
                            result = result && false;
                        } else if (op == '|') {
                            result = result || false;
                        }
                    }
                    if (first) {
                        result = (val == 't');
                        first = false;
                    }
                }
                stack.pop(); // remove '('
                stack.push(result ? 't' : 'f');
            }
        }
        return stack.peek() == 't';
    }
}
}