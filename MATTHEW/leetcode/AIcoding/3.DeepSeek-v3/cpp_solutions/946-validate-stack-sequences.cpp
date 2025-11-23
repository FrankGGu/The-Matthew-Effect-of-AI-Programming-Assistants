class Solution {
public:
    bool validateStackSequences(vector<int>& pushed, vector<int>& popped) {
        stack<int> st;
        int n = pushed.size();
        int j = 0;
        for (int x : pushed) {
            st.push(x);
            while (!st.empty() && j < n && st.top() == popped[j]) {
                st.pop();
                j++;
            }
        }
        return j == n;
    }
};