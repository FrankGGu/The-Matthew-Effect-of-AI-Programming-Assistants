class Solution {
public:
    vector<int> canSeePersonsCount(vector<int>& heights) {
        int n = heights.size();
        vector<int> result(n, 0);
        stack<int> st;

        for (int i = n - 1; i >= 0; --i) {
            while (!st.empty() && st.top() < heights[i]) {
                result[i]++;
                st.pop();
            }
            if (!st.empty()) {
                result[i]++;
            }
            st.push(heights[i]);
        }

        return result;
    }
};