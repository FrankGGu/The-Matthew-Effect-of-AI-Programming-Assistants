#include <iostream>
#include <vector>
#include <string>
#include <stack>

using namespace std;

class Solution {
public:
    bool isValid(string s) {
        stack<char> st;
        for (char c : s) {
            if (c == 'a') {
                st.push(c);
            } else if (c == 'b') {
                if (!st.empty() && st.top() == 'a') {
                    st.pop();
                    st.push('b');
                } else {
                    return false;
                }
            } else if (c == 'c') {
                if (!st.empty() && st.top() == 'b') {
                    st.pop();
                    if (!st.empty() && st.top() == 'a') {
                        st.pop();
                    } else {
                        return false;
                    }
                } else {
                    return false;
                }
            } else {
                return false;
            }
        }
        return st.empty();
    }
};