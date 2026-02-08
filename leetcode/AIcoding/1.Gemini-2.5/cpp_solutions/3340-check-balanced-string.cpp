#include <string>
#include <stack>
#include <map>

class Solution {
public:
    bool isValid(std::string s) {
        std::stack<char> st;
        std::map<char, char> matching_pair = {
            {')', '('},
            {'}', '{'},
            {']', '['}
        };

        for (char c : s) {
            if (c == '(' || c == '{' || c == '[') {
                st.push(c);
            } else if (c == ')' || c == '}' || c == ']') {
                if (st.empty() || st.top() != matching_pair[c]) {
                    return false;
                }
                st.pop();
            }
        }

        return st.empty();
    }
};