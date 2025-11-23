class Solution {
public:
    int evaluate(string expression) {
        unordered_map<string, int> scope;
        return helper(expression, scope);
    }

private:
    int helper(const string& expr, unordered_map<string, int> scope) {
        if (expr[0] != '(') {
            if (isdigit(expr[0]) {
                return stoi(expr);
            } else {
                return scope[expr];
            }
        }

        string op;
        vector<string> tokens;
        int start = 1;
        if (expr.substr(1, 3) == "add") {
            op = "add";
            start = 5;
        } else if (expr.substr(1, 4) == "mult") {
            op = "mult";
            start = 6;
        } else {
            op = "let";
            start = 5;
        }

        int balance = 0;
        string token;
        for (int i = start; i < expr.size() - 1; ++i) {
            char c = expr[i];
            if (c == '(') {
                balance++;
            } else if (c == ')') {
                balance--;
            }
            if (balance == 0 && c == ' ') {
                tokens.push_back(token);
                token.clear();
            } else {
                token += c;
            }
        }
        if (!token.empty()) {
            tokens.push_back(token);
        }

        if (op == "add") {
            return helper(tokens[0], scope) + helper(tokens[1], scope);
        } else if (op == "mult") {
            return helper(tokens[0], scope) * helper(tokens[1], scope);
        } else {
            for (int i = 0; i < tokens.size() - 1; i += 2) {
                string var = tokens[i];
                int val = helper(tokens[i + 1], scope);
                scope[var] = val;
            }
            return helper(tokens.back(), scope);
        }
    }
};