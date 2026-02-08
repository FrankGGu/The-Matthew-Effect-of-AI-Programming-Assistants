class Solution {
public:
    NestedInteger deserialize(string s) {
        if (s.empty()) return NestedInteger();
        if (s[0] != '[') return NestedInteger(stoi(s));
        stack<NestedInteger> st;
        int num = 0;
        int sign = 1;
        bool hasNum = false;
        for (int i = 0; i < s.size(); ++i) {
            char c = s[i];
            if (c == '-') {
                sign = -1;
            } else if (isdigit(c)) {
                num = num * 10 + (c - '0');
                hasNum = true;
            } else if (c == '[') {
                st.push(NestedInteger());
            } else if (c == ',' || c == ']') {
                if (hasNum) {
                    st.top().add(NestedInteger(sign * num));
                    num = 0;
                    sign = 1;
                    hasNum = false;
                }
                if (c == ']' && st.size() > 1) {
                    NestedInteger ni = st.top();
                    st.pop();
                    st.top().add(ni);
                }
            }
        }
        return st.top();
    }
};