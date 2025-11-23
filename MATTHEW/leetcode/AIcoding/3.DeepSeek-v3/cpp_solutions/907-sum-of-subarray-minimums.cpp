class Solution {
public:
    int sumSubarrayMins(vector<int>& arr) {
        int n = arr.size();
        long long res = 0;
        int mod = 1e9 + 7;
        stack<int> st;
        vector<int> left(n), right(n);

        for (int i = 0; i < n; ++i) {
            while (!st.empty() && arr[st.top()] > arr[i]) {
                st.pop();
            }
            left[i] = st.empty() ? -1 : st.top();
            st.push(i);
        }

        st = stack<int>();
        for (int i = n - 1; i >= 0; --i) {
            while (!st.empty() && arr[st.top()] >= arr[i]) {
                st.pop();
            }
            right[i] = st.empty() ? n : st.top();
            st.push(i);
        }

        for (int i = 0; i < n; ++i) {
            res += (long long)arr[i] * (i - left[i]) * (right[i] - i);
            res %= mod;
        }

        return res;
    }
};