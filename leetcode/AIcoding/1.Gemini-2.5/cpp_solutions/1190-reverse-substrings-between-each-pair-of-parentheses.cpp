#include <string>
#include <stack>
#include <algorithm>

class Solution {
public:
    std::string reverseParentheses(std::string s) {
        std::stack<std::string> st;
        std::string current_str;

        for (char c : s) {
            if (c == '(') {
                st.push(current_str);
                current_str = "";
            } else if (c == ')') {
                std::reverse(current_str.begin(), current_str.end());
                current_str = st.top() + current_str;
                st.pop();
            } else {
                current_str += c;
            }
        }
        return current_str;
    }
};