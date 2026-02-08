class Solution {
public:
    int sumOfStrength(vector<int>& strength) {
        int n = strength.size();
        const int MOD = 1e9 + 7;

        vector<long long> prefix_sum(n + 1);
        for (int i = 1; i <= n; ++i) {
            prefix_sum[i] = (prefix_sum[i - 1] + strength[i - 1]) % MOD;
        }

        vector<long long> left(n), right(n);
        stack<int> stk;

        for (int i = 0; i < n; ++i) {
            while (!stk.empty() && strength[stk.top()] < strength[i]) {
                stk.pop();
            }
            left[i] = stk.empty() ? i + 1 : i - stk.top();
            stk.push(i);
        }

        while (!stk.empty()) stk.pop();

        for (int i = n - 1; i >= 0; --i) {
            while (!stk.empty() && strength[stk.top()] <= strength[i]) {
                stk.pop();
            }
            right[i] = stk.empty() ? n - i : stk.top() - i;
            stk.push(i);
        }

        long long total_strength = 0;
        for (int i = 0; i < n; ++i) {
            long long contribution = strength[i] * (left[i] * right[i]) % MOD;
            total_strength = (total_strength + contribution) % MOD;
        }

        return total_strength;
    }
};