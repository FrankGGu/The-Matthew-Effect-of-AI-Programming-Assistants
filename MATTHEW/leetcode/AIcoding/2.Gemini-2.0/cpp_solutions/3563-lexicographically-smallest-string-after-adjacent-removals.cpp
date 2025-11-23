#include <string>
#include <stack>

using namespace std;

string smallestString(string s) {
    stack<char> st;
    for (char c : s) {
        while (!st.empty() && c < st.top() && s.length() - st.size() > 0) {
            st.pop();
        }
        st.push(c);
    }
    string res = "";
    while (!st.empty()) {
        res = st.top() + res;
        st.pop();
    }
    return res;
}