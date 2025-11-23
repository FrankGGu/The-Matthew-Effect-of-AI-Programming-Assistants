class Solution {
    public boolean parseBoolExpr(String expression) {
        Stack<Character> stack = new Stack<>();
        for (char c : expression.toCharArray()) {
            if (c == ',') {
                continue;
            } else if (c != ')') {
                stack.push(c);
            } else {
                List<Boolean> list = new ArrayList<>();
                while (stack.peek() != '(') {
                    list.add(stack.pop() == 't');
                }
                stack.pop(); // pop '('
                char op = stack.pop();
                boolean res = false;
                if (op == '&') {
                    res = true;
                    for (boolean b : list) {
                        res &= b;
                    }
                } else if (op == '|') {
                    res = false;
                    for (boolean b : list) {
                        res |= b;
                    }
                } else if (op == '!') {
                    res = !list.get(0);
                }
                stack.push(res ? 't' : 'f');
            }
        }
        return stack.pop() == 't';
    }
}