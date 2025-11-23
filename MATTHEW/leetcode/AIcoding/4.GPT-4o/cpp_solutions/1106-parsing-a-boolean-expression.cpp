class Solution {
public:
    bool parseBoolExpr(string expression) {
        return eval(expression, 0).first;
    }

private:
    pair<bool, int> eval(const string& expr, int index) {
        char op = expr[index];
        if (op == 't') return {true, index + 1};
        if (op == 'f') return {false, index + 1};
        if (op == '!') {
            auto [val, nextIndex] = eval(expr, index + 2);
            return { !val, nextIndex + 1 };
        }

        vector<bool> values;
        index += 2; // Skip the operator and '('
        while (expr[index] != ')') {
            auto [val, nextIndex] = eval(expr, index);
            values.push_back(val);
            index = nextIndex;
            if (expr[index] == ',') index++; // Skip the comma
        }

        if (op == '&') return { all_of(values.begin(), values.end(), [](bool v) { return v; }), index + 1 };
        if (op == '|') return { any_of(values.begin(), values.end(), [](bool v) { return v; }), index + 1 };

        return { false, index + 1 }; // Should not reach here
    }
};