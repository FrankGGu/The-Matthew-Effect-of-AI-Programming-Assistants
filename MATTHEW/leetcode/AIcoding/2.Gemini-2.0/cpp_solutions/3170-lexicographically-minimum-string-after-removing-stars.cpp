#include <string>
#include <stack>

using namespace std;

class Solution {
public:
    string removeStars(string s) {
        stack<char> st;
        for (char c : s) {
            if (c == '*') {
                if (!st.empty()) {
                    st.pop();
                }
            } else {
                st.push(c);
            }
        }

        string result = "";
        while (!st.empty()) {
            result = st.top() + result;
            st.pop();
        }

        return result;
    }
};