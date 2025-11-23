class Solution {
public:
    vector<string> braceExpansionII(string expression) {
        vector<string> res;
        stack<vector<string>> stackStr;
        stack<char> stackOp;
        for (int i = 0; i < expression.size(); ++i) {
            char c = expression[i];
            if (c == '{') {
                if (i > 0 && (expression[i-1] == '}' || isalpha(expression[i-1]))) {
                    stackOp.push('*');
                }
                stackOp.push('{');
            } else if (c == '}') {
                while (stackOp.top() != '{') {
                    vector<string> b = stackStr.top(); stackStr.pop();
                    vector<string> a = stackStr.top(); stackStr.pop();
                    char op = stackOp.top(); stackOp.pop();
                    if (op == '+') {
                        a.insert(a.end(), b.begin(), b.end());
                    } else {
                        vector<string> tmp;
                        for (const string& s1 : a) {
                            for (const string& s2 : b) {
                                tmp.push_back(s1 + s2);
                            }
                        }
                        a = tmp;
                    }
                    stackStr.push(a);
                }
                stackOp.pop();
            } else if (c == ',') {
                stackOp.push('+');
            } else {
                string s;
                s += c;
                if (i > 0 && (expression[i-1] == '}' || isalpha(expression[i-1]))) {
                    stackOp.push('*');
                }
                stackStr.push({s});
            }
        }
        while (!stackOp.empty()) {
            vector<string> b = stackStr.top(); stackStr.pop();
            vector<string> a = stackStr.top(); stackStr.pop();
            char op = stackOp.top(); stackOp.pop();
            if (op == '+') {
                a.insert(a.end(), b.begin(), b.end());
            } else {
                vector<string> tmp;
                for (const string& s1 : a) {
                    for (const string& s2 : b) {
                        tmp.push_back(s1 + s2);
                    }
                }
                a = tmp;
            }
            stackStr.push(a);
        }
        res = stackStr.top();
        sort(res.begin(), res.end());
        res.erase(unique(res.begin(), res.end()), res.end());
        return res;
    }
};