class Solution {
public:
    bool parseBoolExpr(string expression) {
        stack<char> st;
        for (char c : expression) {
            if (c == ',') continue;
            if (c != ')') {
                st.push(c);
            } else {
                vector<bool> vals;
                while (st.top() != '(') {
                    vals.push_back(st.top() == 't');
                    st.pop();
                }
                st.pop(); // pop '('
                char op = st.top();
                st.pop();
                bool res;
                if (op == '!') {
                    res = !vals[0];
                } else if (op == '&') {
                    res = true;
                    for (bool v : vals) res &= v;
                } else if (op == '|') {
                    res = false;
                    for (bool v : vals) res |= v;
                }
                st.push(res ? 't' : 'f');
            }
        }
        return st.top() == 't';
    }
};