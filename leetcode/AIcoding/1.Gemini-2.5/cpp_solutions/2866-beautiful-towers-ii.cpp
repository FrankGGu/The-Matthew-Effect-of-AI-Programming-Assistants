#include <vector>
#include <stack>
#include <algorithm>

class Solution {
public:
    long long maximumSumOfHeights(std::vector<int>& maxHeights) {
        int n = maxHeights.size();
        std::vector<long long> left_sums(n);
        std::vector<long long> right_sums(n);
        std::stack<int> st;

        // Calculate left_sums: max sum of h_0, ..., h_i such that h_k <= maxHeights[k] and h_0 <= ... <= h_i
        for (int i = 0; i < n; ++i) {
            while (!st.empty() && maxHeights[st.top()] >= maxHeights[i]) {
                st.pop();
            }
            long long prev_sum = st.empty() ? 0 : left_sums[st.top()];
            long long prev_idx = st.empty() ? -1 : st.top();
            left_sums[i] = prev_sum + (long long)maxHeights[i] * (i - prev_idx);
            st.push(i);
        }

        // Clear stack for right_sums calculation
        while (!st.empty()) {
            st.pop();
        }

        // Calculate right_sums: max sum of h_i, ..., h_{n-1} such that h_k <= maxHeights[k] and h_i >= ... >= h_{n-1}
        for (int i = n - 1; i >= 0; --i) {
            while (!st.empty() && maxHeights[st.top()] >= maxHeights[i]) {
                st.pop();
            }
            long long prev_sum = st.empty() ? 0 : right_sums[st.top()];
            long long prev_idx = st.empty() ? n : st.top();
            right_sums[i] = prev_sum + (long long)maxHeights[i] * (prev_idx - i);
            st.push(i);
        }

        long long max_total_sum = 0;
        for (int i = 0; i < n; ++i) {
            max_total_sum = std::max(max_total_sum, left_sums[i] + right_sums[i] - maxHeights[i]);
        }

        return max_total_sum;
    }
};