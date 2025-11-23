#include <iostream>
#include <vector>
#include <stack>
#include <sstream>

using namespace std;

class Solution {
public:
    NestedInteger deserialize(string s) {
        if (s.empty()) return NestedInteger();
        if (s[0] != '[') return NestedInteger(stoi(s));

        stack<NestedInteger> st;
        int num = 0;
        bool negative = false;
        bool isNum = false;

        for (int i = 1; i < s.length(); ++i) {
            if (s[i] == '[') {
                st.push(NestedInteger());
                isNum = false;
            } else if (s[i] == ']') {
                if (isNum) {
                    st.top().add(NestedInteger(num));
                    isNum = false;
                }
                if (st.size() > 1) {
                    NestedInteger temp = st.top();
                    st.pop();
                    st.top().add(temp);
                }
            } else if (s[i] == ',') {
                if (isNum) {
                    st.top().add(NestedInteger(num));
                    isNum = false;
                }
            } else if (s[i] == '-') {
                negative = true;
            } else {
                num = num * 10 + (s[i] - '0');
                isNum = true;
            }
        }

        return st.top();
    }
};