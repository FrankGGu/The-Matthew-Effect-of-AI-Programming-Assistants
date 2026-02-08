#include <iostream>
#include <vector>
#include <string>
#include <stack>

using namespace std;

class Solution {
public:
    string minRemoveToMakeValid(string s) {
        stack<int> st;
        vector<bool> toRemove(s.size(), false);

        for (int i = 0; i < s.size(); ++i) {
            if (s[i] == '(') {
                st.push(i);
            } else if (s[i] == ')') {
                if (!st.empty()) {
                    st.pop();
                } else {
                    toRemove[i] = true;
                }
            }
        }

        while (!st.empty()) {
            toRemove[st.top()] = true;
            st.pop();
        }

        string result;
        for (int i = 0; i < s.size(); ++i) {
            if (!toRemove[i]) {
                result += s[i];
            }
        }

        return result;
    }
};