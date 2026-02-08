#include <vector>
#include <stack>
#include <algorithm> // For std::max

class Solution {
public:
    int maxSumMinProduct(std::vector<int>& nums) {
        int n = nums.size();

        std::vector<long long> prefix_sum(n + 1, 0);
        for (int i = 0; i < n; ++i) {
            prefix_sum[i + 1] = prefix_sum[i] + nums[i];
        }

        std::vector<int> left(n);
        std::stack<int> st;
        for (int i = 0; i < n; ++i) {
            while (!st.empty() && nums[st.top()] >= nums[i]) {
                st.pop();
            }
            left[i] = st.empty() ? -1 : st.top();
            st.push(i);
        }

        std::vector<int> right(n);
        while (!st.empty()) {
            st.pop();
        }
        for (int i = n - 1; i >= 0; --i) {
            while (!st.empty() && nums[st.top()] >= nums[i]) {
                st.pop();
            }
            right[i] = st.empty() ? n : st.top();
            st.push(i);
        }

        long long max_product = 0;
        for (int i = 0; i < n; ++i) {
            long long current_sum = prefix_sum[right[i]] - prefix_sum[left[i] + 1];
            long long current_product = (long long)nums[i] * current_sum;
            max_product = std::max(max_product, current_product);
        }

        return max_product % (1000000000 + 7);
    }
};