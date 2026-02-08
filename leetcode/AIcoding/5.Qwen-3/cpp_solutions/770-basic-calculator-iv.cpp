#include <iostream>
#include <vector>
#include <string>
#include <unordered_map>
#include <stack>
#include <sstream>

using namespace std;

class Solution {
public:
    vector<string> parse(string s) {
        vector<string> tokens;
        stringstream ss(s);
        string token;
        while (getline(ss, token, ' ')) {
            if (!token.empty()) {
                tokens.push_back(token);
            }
        }
        return tokens;
    }

    int precedence(char op) {
        if (op == '+' || op == '-') return 1;
        if (op == '*' || op == '/') return 2;
        return 0;
    }

    vector<string> infixToPostfix(vector<string>& tokens) {
        vector<string> output;
        stack<char> ops;
        for (string token : tokens) {
            if (isdigit(token[0])) {
                output.push_back(token);
            } else if (token == "(") {
                ops.push('(');
            } else if (token == ")") {
                while (!ops.empty() && ops.top() != '(') {
                    output.push_back(string(1, ops.top()));
                    ops.pop();
                }
                ops.pop();             } else {
                while (!ops.empty() && precedence(ops.top()) >= precedence(token[0])) {
                    output.push_back(string(1, ops.top()));
                    ops.pop();
                }
                ops.push(token[0]);
            }
        }
        while (!ops.empty()) {
            output.push_back(string(1, ops.top()));
            ops.pop();
        }
        return output;
    }

    int evaluatePostfix(vector<string>& postfix) {
        stack<int> values;
        for (string token : postfix) {
            if (isdigit(token[0])) {
                values.push(stoi(token));
            } else {
                int b = values.top(); values.pop();
                int a = values.top(); values.pop();
                switch (token[0]) {
                    case '+': values.push(a + b); break;
                    case '-': values.push(a - b); break;
                    case '*': values.push(a * b); break;
                    case '/': values.push(a / b); break;
                }
            }
        }
        return values.top();
    }

    vector<string> basicCalculatorIV(string s, vector<string>& nums, vector<string>& vars) {
        unordered_map<string, int> varMap;
        for (int i = 0; i < vars.size(); ++i) {
            varMap[vars[i]] = stoi(nums[i]);
        }

        vector<string> tokens = parse(s);
        vector<string> postfix = infixToPostfix(tokens);

        stack<int> evalStack;
        for (string token : postfix) {
            if (isdigit(token[0])) {
                evalStack.push(stoi(token));
            } else if (varMap.find(token) != varMap.end()) {
                evalStack.push(varMap[token]);
            } else {
                int b = evalStack.top(); evalStack.pop();
                int a = evalStack.top(); evalStack.pop();
                switch (token[0]) {
                    case '+': evalStack.push(a + b); break;
                    case '-': evalStack.push(a - b); break;
                    case '*': evalStack.push(a * b); break;
                    case '/': evalStack.push(a / b); break;
                }
            }
        }

        return {to_string(evalStack.top())};
    }
};