class Solution {
    public boolean parseBoolExpr(String expression) {
        return evaluate(expression, new int[]{0});
    }

    private boolean evaluate(String expr, int[] index) {
        char op = expr.charAt(index[0]);
        index[0]++;

        if (op == 't') {
            return true;
        }
        if (op == 'f') {
            return false;
        }
        if (op == '!') {
            return !evaluate(expr, index);
        }

        boolean res = op == '&';
        boolean first = true;

        while (index[0] < expr.length()) {
            char ch = expr.charAt(index[0]);
            if (ch == ')') {
                index[0]++;
                break;
            }
            if (ch == ',') {
                index[0]++;
                continue;
            }
            boolean current = evaluate(expr, index);
            if (first) {
                res = current;
                first = false;
            } else {
                res = op == '&' ? res && current : res || current;
            }
        }
        return res;
    }
}