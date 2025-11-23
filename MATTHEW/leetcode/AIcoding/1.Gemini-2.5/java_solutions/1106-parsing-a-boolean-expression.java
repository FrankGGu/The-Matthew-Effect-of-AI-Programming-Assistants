class Solution {
    public boolean parseBoolExpr(String expression) {
        int[] index = {0}; // Use an array to pass index by reference
        return parse(expression, index);
    }

    private boolean parse(String expression, int[] index) {
        char op = expression.charAt(index[0]);
        index[0]++; // Move past the operator or literal

        if (op == 't') {
            return true;
        }
        if (op == 'f') {
            return false;
        }

        // For '!', '&', '|', expect '(' next
        // index[0] is now pointing to '(', move past it
        index[0]++; 

        if (op == '!') {
            boolean val = parse(expression, index);
            index[0]++; // Move past ')'
            return !val;
        }

        boolean result;
        if (op == '&') {
            result = true;
            while (expression.charAt(index[0]) != ')') {
                result = result && parse(expression, index);
                if (expression.charAt(index[0]) == ',') {
                    index[0]++; // Move past ','
                }
            }
            index[0]++; // Move past ')'
            return result;
        }

        // op == '|'
        result = false;
        while (expression.charAt(index[0]) != ')') {
            result = result || parse(expression, index);
            if (expression.charAt(index[0]) == ',') {
                index[0]++; // Move past ','
            }
        }
        index[0]++; // Move past ')'
        return result;
    }
}