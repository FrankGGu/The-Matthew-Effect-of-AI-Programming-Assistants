class Solution {
public:
    int totalStrength(vector<int>& strength) {
        const int MOD = 1e9 + 7;
        int n = strength.size();
        vector<int> left(n, -1), right(n, n);
        stack<int> st;

        for (int i = 0; i < n; ++i) {
            while (!st.empty() && strength[st.top()] >= strength[i]) {
                st.pop();
            }
            if (!st.empty()) {
                left[i] = st.top();
            }
            st.push(i);
        }

        st = stack<int>();
        for (int i = n - 1; i >= 0; --i) {
            while (!st.empty() && strength[st.top()] > strength[i]) {
                st.pop();
            }
            if (!st.empty()) {
                right[i] = st.top();
            }
            st.push(i);
        }

        vector<long long> prefix(n + 2, 0);
        for (int i = 0; i < n; ++i) {
            prefix[i + 1] = (prefix[i] + strength[i]) % MOD;
        }

        vector<long long> prefix_prefix(n + 2, 0);
        for (int i = 0; i <= n; ++i) {
            prefix_prefix[i + 1] = (prefix_prefix[i] + prefix[i]) % MOD;
        }

        long long res = 0;
        for (int i = 0; i < n; ++i) {
            int l = left[i] + 1, r = right[i] - 1;
            long long sum_left = (prefix_prefix[i + 1] - prefix_prefix[l] + MOD) % MOD;
            long long sum_right = (prefix_prefix[r + 2] - prefix_prefix[i + 2] + MOD) % MOD;
            long long total = (sum_right * (i - l + 1) % MOD;
            total = (total - sum_left * (r - i + 1) % MOD + MOD) % MOD;
            res = (res + strength[i] * total) % MOD;
        }
        return res;
    }
};