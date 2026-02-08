#include <string>
#include <stack>
#include <algorithm> // For std::max

class Solution {
public:
    int longestValidParentheses(std::string s) {
        int max_len = 0;
        std::stack<int> st;
        st.push(-1); // Push a base index

        for (int i = 0; i < s.length(); ++i) {
            if (s[i] == '(') {
                st.push(i);
            } else { // s[i] == ')'
                st.pop();
                if (st.empty()) {
                    st.push(i); // Push current index as a new base
                } else {
                    max_len = std::max(max_len, i - st.top());
                }
            }
        }
        return max_len;
    }
};