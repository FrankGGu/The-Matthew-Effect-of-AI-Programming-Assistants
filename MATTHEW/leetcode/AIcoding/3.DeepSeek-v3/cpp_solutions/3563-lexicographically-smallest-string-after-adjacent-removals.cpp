#include <vector>
#include <string>
#include <stack>

using namespace std;

class Solution {
public:
    string smallestString(string s) {
        stack<char> st;
        for (char c : s) {
            while (!st.empty() && st.top() > c) {
                st.pop();
            }
            st.push(c);
        }
        string result;
        while (!st.empty()) {
            result = st.top() + result;
            st.pop();
        }
        return result;
    }
};