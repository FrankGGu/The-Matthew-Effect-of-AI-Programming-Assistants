#include <string>
#include <stack>

using namespace std;

class Solution {
public:
    string removeDuplicates(string s, int k) {
        stack<pair<char, int>> st;
        for (char c : s) {
            if (!st.empty() && st.top().first == c) {
                st.top().second++;
                if (st.top().second == k) {
                    st.pop();
                }
            } else {
                st.push({c, 1});
            }
        }
        string result = "";
        while (!st.empty()) {
            char c = st.top().first;
            int count = st.top().second;
            st.pop();
            for (int i = 0; i < count; ++i) {
                result = c + result;
            }
        }
        return result;
    }
};