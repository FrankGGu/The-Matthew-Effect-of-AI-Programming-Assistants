class Solution {
public:
    string robotWithString(string s) {
        int n = s.size();
        vector<char> minRight(n);
        minRight[n - 1] = s[n - 1];
        for (int i = n - 2; i >= 0; --i) {
            minRight[i] = min(s[i], minRight[i + 1]);
        }

        stack<char> st;
        string res;
        for (int i = 0; i < n; ++i) {
            st.push(s[i]);
            while (!st.empty() && (i == n - 1 || st.top() <= minRight[i + 1])) {
                res.push_back(st.top());
                st.pop();
            }
        }
        return res;
    }
};