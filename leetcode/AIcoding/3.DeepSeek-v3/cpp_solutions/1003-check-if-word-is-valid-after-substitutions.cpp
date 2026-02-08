class Solution {
public:
    bool isValid(string s) {
        stack<char> st;
        for (char c : s) {
            st.push(c);
            if (st.size() >= 3) {
                char third = st.top(); st.pop();
                char second = st.top(); st.pop();
                char first = st.top(); st.pop();
                if (first == 'a' && second == 'b' && third == 'c') {
                    continue;
                } else {
                    st.push(first);
                    st.push(second);
                    st.push(third);
                }
            }
        }
        return st.empty();
    }
};