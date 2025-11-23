#include <iostream>
#include <vector>
#include <string>
#include <stack>
#include <map>
#include <sstream>

using namespace std;

class Solution {
public:
    int evaluate(string expression) {
        istringstream iss(expression);
        return eval(iss, nullptr);
    }

private:
    int eval(istringstream& iss, map<string, int>* env) {
        char c;
        string token;
        while (iss >> c) {
            if (c == '(') {
                return eval(iss, env);
            } else if (c == ')') {
                return 0;
            } else if (c == ' ') {
                continue;
            } else {
                iss.putback(c);
                iss >> token;
                if (token[0] == '(') {
                    return eval(iss, env);
                } else if (token[0] == ' ') {
                    continue;
                } else if (token == "if") {
                    int cond = eval(iss, env);
                    int thenExpr = eval(iss, env);
                    int elseExpr = eval(iss, env);
                    return cond ? thenExpr : elseExpr;
                } else if (token == "let") {
                    map<string, int> newEnv(*env);
                    while (true) {
                        iss >> token;
                        if (token == ")") {
                            return eval(iss, &newEnv);
                        }
                        if (token[0] == '(') {
                            return eval(iss, &newEnv);
                        }
                        if (token == " ") {
                            continue;
                        }
                        string var = token;
                        iss >> token;
                        if (token == ")") {
                            return newEnv[var];
                        }
                        int val = eval(iss, &newEnv);
                        newEnv[var] = val;
                    }
                } else if (token[0] == '-') {
                    int num = 0;
                    for (int i = 1; i < token.size(); ++i) {
                        num = num * 10 + (token[i] - '0');
                    }
                    return -num;
                } else {
                    if (token[0] >= '0' && token[0] <= '9') {
                        return stoi(token);
                    } else {
                        return (*env)[token];
                    }
                }
            }
        }
        return 0;
    }
};