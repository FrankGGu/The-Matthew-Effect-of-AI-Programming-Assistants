class Solution {
public:
    int minOperationsToFlip(string expression) {
        stack<pair<int, int>> val_stack;
        stack<char> op_stack;
        for (char c : expression) {
            if (c == '(' || c == '&' || c == '|') {
                op_stack.push(c);
            } else if (c == '0' || c == '1') {
                int curr_val = c - '0';
                int curr_cost = 1;
                val_stack.push({curr_val, curr_cost});
                evaluate(val_stack, op_stack);
            } else if (c == ')') {
                op_stack.pop(); // pop '('
                evaluate(val_stack, op_stack);
            }
        }
        return val_stack.top().second;
    }

private:
    void evaluate(stack<pair<int, int>>& val_stack, stack<char>& op_stack) {
        if (op_stack.empty() || op_stack.top() == '(') {
            return;
        }
        char op = op_stack.top();
        op_stack.pop();

        auto right = val_stack.top(); val_stack.pop();
        auto left = val_stack.top(); val_stack.pop();

        int res_val, res_cost;
        if (op == '&') {
            if (left.first == 1 && right.first == 1) {
                res_val = 1;
                res_cost = min(left.second, right.second);
            } else if (left.first == 0 && right.first == 0) {
                res_val = 0;
                res_cost = min(left.second + right.second, 1 + min(left.second, right.second));
            } else {
                res_val = 0;
                res_cost = 1;
            }
        } else { // '|'
            if (left.first == 0 && right.first == 0) {
                res_val = 0;
                res_cost = min(left.second, right.second);
            } else if (left.first == 1 && right.first == 1) {
                res_val = 1;
                res_cost = min(left.second + right.second, 1 + min(left.second, right.second));
            } else {
                res_val = 1;
                res_cost = 1;
            }
        }
        val_stack.push({res_val, res_cost});
    }
};