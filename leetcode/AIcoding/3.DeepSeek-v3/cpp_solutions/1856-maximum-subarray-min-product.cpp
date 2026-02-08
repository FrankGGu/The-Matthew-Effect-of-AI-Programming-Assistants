class Solution {
public:
    int maxSumMinProduct(vector<int>& nums) {
        int n = nums.size();
        vector<long long> prefix(n + 1, 0);
        for (int i = 0; i < n; ++i) {
            prefix[i + 1] = prefix[i] + nums[i];
        }

        stack<int> st;
        vector<int> left(n, -1);
        for (int i = 0; i < n; ++i) {
            while (!st.empty() && nums[st.top()] >= nums[i]) {
                st.pop();
            }
            if (!st.empty()) {
                left[i] = st.top();
            }
            st.push(i);
        }

        st = stack<int>();
        vector<int> right(n, n);
        for (int i = n - 1; i >= 0; --i) {
            while (!st.empty() && nums[st.top()] >= nums[i]) {
                st.pop();
            }
            if (!st.empty()) {
                right[i] = st.top();
            }
            st.push(i);
        }

        long long res = 0;
        for (int i = 0; i < n; ++i) {
            int l = left[i] + 1;
            int r = right[i] - 1;
            long long sum = prefix[r + 1] - prefix[l];
            res = max(res, sum * nums[i]);
        }

        return res % 1000000007;
    }
};