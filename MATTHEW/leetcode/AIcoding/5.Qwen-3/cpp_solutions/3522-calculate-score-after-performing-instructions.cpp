#include <iostream>
#include <vector>
#include <stack>

using namespace std;

class Solution {
public:
    int scoreAfterInstructions(string s) {
        stack<int> st;
        int score = 0;
        for (char c : s) {
            if (c == 'D') {
                st.push(st.top() * 2);
            } else if (c == 'C') {
                st.pop();
            } else if (c == 'B') {
                st.push(st.top() - 1);
            } else {
                st.push(1);
            }
        }
        while (!st.empty()) {
            score += st.top();
            st.pop();
        }
        return score;
    }
};