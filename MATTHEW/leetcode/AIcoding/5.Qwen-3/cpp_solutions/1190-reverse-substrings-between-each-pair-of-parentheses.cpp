#include <iostream>
#include <vector>
#include <stack>
#include <string>

using namespace std;

class Solution {
public:
    string reverseParentheses(string s) {
        stack<string> st;
        string current = "";
        for (char c : s) {
            if (c == '(') {
                st.push(current);
                current = "";
            } else if (c == ')') {
                string temp = current;
                current = st.top();
                st.pop();
                for (int i = temp.size() - 1; i >= 0; --i) {
                    current += temp[i];
                }
            } else {
                current += c;
            }
        }
        return current;
    }
};