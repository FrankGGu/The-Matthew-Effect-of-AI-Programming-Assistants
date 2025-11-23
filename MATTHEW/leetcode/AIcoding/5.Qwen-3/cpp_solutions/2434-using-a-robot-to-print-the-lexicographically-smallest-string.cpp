#include <iostream>
#include <vector>
#include <string>
#include <stack>

using namespace std;

class Solution {
public:
    string robotWithString(string s) {
        vector<int> count(26, 0);
        for (char c : s) {
            count[c - 'a']++;
        }

        stack<char> st;
        string result;

        for (char c : s) {
            while (!st.empty() && st.top() <= c) {
                result += st.top();
                st.pop();
            }
            st.push(c);
        }

        while (!st.empty()) {
            result += st.top();
            st.pop();
        }

        return result;
    }
};