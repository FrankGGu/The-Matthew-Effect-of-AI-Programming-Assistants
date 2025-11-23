#include <string>
#include <stack>
#include <unordered_set>

class Solution {
public:
    bool parseBoolExpr(std::string expression) {
        std::stack<char> st;
        for (char c : expression) {
            if (c == ')') {
                std::unordered_set<char> seen;
                while (st.top() != '(') {
                    seen.insert(st.top());
                    st.pop();
                }
                st.pop(); // pop '('
                char op = st.top();
                st.pop(); // pop operator

                if (op == '!') {
                    st.push(seen.count('f') ? 't' : 'f');
                } else if (op == '&') {
                    st.push(seen.count('f') ? 'f' : 't');
                } else { // op == '|'
                    st.push(seen.count('t') ? 't' : 'f');
                }
            } else if (c != ',') {
                st.push(c);
            }
        }
        return st.top() == 't';
    }
};