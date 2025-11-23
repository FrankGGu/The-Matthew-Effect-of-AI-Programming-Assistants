#include <iostream>
#include <vector>
#include <stack>
#include <string>

using namespace std;

class Solution {
public:
    int scoreOfParentheses(string s) {
        stack<int> st;
        for (char c : s) {
            if (c == '(') {
                st.push(0);
            } else {
                int top = st.top();
                st.pop();
                if (top == 0) {
                    st.top() += 1;
                } else {
                    st.top() += top * 2;
                }
            }
        }
        return st.top();
    }
};