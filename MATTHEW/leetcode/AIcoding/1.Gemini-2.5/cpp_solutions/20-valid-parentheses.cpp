#include <string>
#include <stack>
#include <map>

class Solution {
public:
    bool isValid(std::string s) {
        std::stack<char> st;
        std::map<char, char> matching = {
            {')', '('},
            {']', '['},
            {'}', '{'}
        };

        for (char c : s) {
            if (c == '(' || c == '[' || c == '{') {
                st.push(c);
            } else if (c == ')' || c == ']' || c == '}') {
                if (st.empty()) {
                    return false;
                }
                if (st.top() == matching[c]) {
                    st.pop();
                } else {
                    return false;
                }
            }
        }

        return st.empty();
    }
};