class Solution {
public:
    int sumSubarrayMin(vector<int>& arr) {
        const int MOD = 1e9 + 7;
        int n = arr.size();
        vector<long long> left(n), right(n);
        stack<int> s;

        for (int i = 0; i < n; ++i) {
            while (!s.empty() && arr[s.top()] > arr[i]) {
                s.pop();
            }
            left[i] = s.empty() ? i + 1 : i - s.top();
            s.push(i);
        }

        while (!s.empty()) s.pop();

        for (int i = n - 1; i >= 0; --i) {
            while (!s.empty() && arr[s.top()] >= arr[i]) {
                s.pop();
            }
            right[i] = s.empty() ? n - i : s.top() - i;
            s.push(i);
        }

        long long result = 0;
        for (int i = 0; i < n; ++i) {
            result = (result + arr[i] * left[i] * right[i]) % MOD;
        }

        return result;
    }
};