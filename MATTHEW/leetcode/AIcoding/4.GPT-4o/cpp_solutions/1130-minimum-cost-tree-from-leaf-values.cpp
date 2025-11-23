class Solution {
public:
    int mctFromLeafValues(vector<int>& arr) {
        int n = arr.size();
        if (n == 1) return 0;

        stack<int> st;
        int cost = 0;

        for (int i = 0; i < n; ++i) {
            while (!st.empty() && st.top() <= arr[i]) {
                int mid = st.top();
                st.pop();
                if (st.empty()) {
                    cost += mid * arr[i];
                } else {
                    cost += mid * min(st.top(), arr[i]);
                }
            }
            st.push(arr[i]);
        }

        while (st.size() > 1) {
            int mid = st.top();
            st.pop();
            cost += mid * st.top();
        }

        return cost;
    }
};