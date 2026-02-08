#include <string>
#include <stack>

using namespace std;

class Solution {
public:
    int scoreOfParentheses(string s) {
        stack<int> st;
        st.push(0);

        for (char c : s) {
            if (c == '(') {
                st.push(0);
            } else {
                int val = st.top();
                st.pop();
                int prev = st.top();
                st.pop();
                st.push(prev + max(2 * val, 1));
            }
        }

        return st.top();
    }
};