#include <iostream>
#include <vector>
#include <string>
#include <stack>
#include <unordered_map>

using namespace std;

class Solution {
public:
    string removeDuplicateLetters(string s) {
        vector<int> lastIndices(26, 0);
        for (int i = 0; i < s.size(); ++i) {
            lastIndices[s[i] - 'a'] = i;
        }

        vector<bool> visited(26, false);
        stack<char> st;

        for (int i = 0; i < s.size(); ++i) {
            char c = s[i];
            if (visited[c - 'a']) continue;

            while (!st.empty() && st.top() > c && lastIndices[st.top() - 'a'] > i) {
                visited[st.top() - 'a'] = false;
                st.pop();
            }

            st.push(c);
            visited[c - 'a'] = true;
        }

        string result;
        while (!st.empty()) {
            result.push_back(st.top());
            st.pop();
        }
        reverse(result.begin(), result.end());
        return result;
    }
};