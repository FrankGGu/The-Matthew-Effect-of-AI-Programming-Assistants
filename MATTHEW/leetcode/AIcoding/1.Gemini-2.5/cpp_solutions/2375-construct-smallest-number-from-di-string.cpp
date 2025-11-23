#include <string>
#include <stack>
#include <algorithm> // Required for std::reverse if using a different approach, but not for this stack-based one.

class Solution {
public:
    std::string constructSmallestNumber(std::string s) {
        std::string result = "";
        std::stack<int> st;
        int current_num = 1;

        for (int i = 0; i < s.length(); ++i) {
            st.push(current_num);
            current_num++;

            if (s[i] == 'I') {
                while (!st.empty()) {
                    result += std::to_string(st.top());
                    st.pop();
                }
            }
        }

        // Push the last number (S.length() + 1-th digit)
        st.push(current_num);

        // Pop any remaining numbers from the stack
        while (!st.empty()) {
            result += std::to_string(st.top());
            st.pop();
        }

        return result;
    }
};