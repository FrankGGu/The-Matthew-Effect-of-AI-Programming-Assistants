class Solution {
public:
    string evaluate(string expression) {
        return evaluateExpression(expression, 0).first;
    }

private:
    pair<string, int> evaluateExpression(const string& expr, int index) {
        if (expr[index] != '(') {
            int end = index;
            while (end < expr.size() && expr[end] != ')') end++;
            return {expr.substr(index, end - index), end};
        }

        index++; // skip '('
        string op = "";
        while (expr[index] != ' ') {
            op += expr[index++];
        }
        index++; // skip space

        vector<string> args;
        while (expr[index] != ')') {
            auto [result, nextIndex] = evaluateExpression(expr, index);
            args.push_back(result);
            index = nextIndex;
            if (expr[index] == ' ') index++; // skip space
        }
        index++; // skip ')'

        if (op == "add") {
            int sum = 0;
            for (const auto& arg : args) {
                sum += stoi(arg);
            }
            return {to_string(sum), index};
        } else if (op == "mult") {
            int product = 1;
            for (const auto& arg : args) {
                product *= stoi(arg);
            }
            return {to_string(product), index};
        } else {
            return {op, index}; // for variable names
        }
    }
};