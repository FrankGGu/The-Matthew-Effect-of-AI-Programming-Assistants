#include <string>
#include <stack>

using namespace std;

class Solution {
public:
    string smallestNumber(string pattern) {
        string result = "";
        stack<int> st;
        int num = 1;

        for (char c : pattern) {
            if (c == 'I') {
                st.push(num++);
                while (!st.empty()) {
                    result += to_string(st.top());
                    st.pop();
                }
            } else {
                st.push(num++);
            }
        }

        st.push(num);
        while (!st.empty()) {
            result += to_string(st.top());
            st.pop();
        }

        return result;
    }
};