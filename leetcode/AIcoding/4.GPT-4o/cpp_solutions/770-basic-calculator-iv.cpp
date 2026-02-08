class Solution {
public:
    vector<string> basicCalculatorIV(string expression, vector<string>& evalvars, vector<int>& evalints) {
        unordered_map<string, int> varMap;
        for (int i = 0; i < evalvars.size(); ++i) {
            varMap[evalvars[i]] = evalints[i];
        }

        // Tokenize the expression
        vector<string> tokens;
        string token;
        for (char c : expression) {
            if (c == ' ' && !token.empty()) {
                tokens.push_back(token);
                token.clear();
            } else if (c != ' ') {
                token += c;
            }
        }
        if (!token.empty()) {
            tokens.push_back(token);
        }

        // Evaluate the expression
        return evaluate(tokens, varMap);
    }

private:
    vector<string> evaluate(const vector<string>& tokens, unordered_map<string, int>& varMap) {
        unordered_map<string, int> countMap;
        stack<int> nums;
        stack<char> ops;

        for (const string& token : tokens) {
            if (isdigit(token[0]) || (token[0] == '-' && token.size() > 1)) {
                nums.push(stoi(token));
            } else if (isalpha(token[0])) {
                if (varMap.count(token)) {
                    nums.push(varMap[token]);
                } else {
                    countMap[token]++;
                }
            } else if (token == "+" || token == "-") {
                while (!ops.empty() && (ops.top() == '+' || ops.top() == '-')) {
                    compute(nums, ops, countMap);
                }
                ops.push(token[0]);
            } else if (token == "*" || token == "/") {
                while (!ops.empty() && (ops.top() == '*' || ops.top() == '/')) {
                    compute(nums, ops, countMap);
                }
                ops.push(token[0]);
            }
        }

        while (!ops.empty()) {
            compute(nums, ops, countMap);
        }

        vector<string> result;
        for (const auto& [var, count] : countMap) {
            if (count > 0) {
                result.push_back(count > 1 ? to_string(count) + "*" + var : var);
            }
        }
        if (!nums.empty()) {
            result.push_back(to_string(nums.top()));
        }
        sort(result.begin(), result.end());
        return result;
    }

    void compute(stack<int>& nums, stack<char>& ops, unordered_map<string, int>& countMap) {
        int b = nums.top(); nums.pop();
        int a = nums.top(); nums.pop();
        char op = ops.top(); ops.pop();

        if (op == '+') {
            nums.push(a + b);
        } else if (op == '-') {
            nums.push(a - b);
        } else if (op == '*') {
            nums.push(a * b);
        } else if (op == '/') {
            nums.push(a / b);
        }
    }
};