#include <string>
#include <vector>
#include <stack>
#include <unordered_set>

using namespace std;

string removeDuplicateLetters(string s) {
    vector<int> lastIndex(26, 0);
    for (int i = 0; i < s.size(); ++i) {
        lastIndex[s[i] - 'a'] = i;
    }

    stack<char> st;
    unordered_set<char> inStack;

    for (int i = 0; i < s.size(); ++i) {
        if (inStack.count(s[i]) == 0) {
            while (!st.empty() && st.top() > s[i] && lastIndex[st.top() - 'a'] > i) {
                inStack.erase(st.top());
                st.pop();
            }
            st.push(s[i]);
            inStack.insert(s[i]);
        }
    }

    string result;
    while (!st.empty()) {
        result += st.top();
        st.pop();
    }

    reverse(result.begin(), result.end());
    return result;
}