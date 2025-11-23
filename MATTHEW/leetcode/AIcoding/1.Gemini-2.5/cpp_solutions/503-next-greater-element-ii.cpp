#include <vector>
#include <stack>

class Solution {
public:
    std::vector<int> nextGreaterElements(std::vector<int>& nums) {
        int n = nums.size();
        std::vector<int> ans(n, -1);
        std::stack<int> st;

        for (int i = 2 * n - 1; i >= 0; --i) {
            int current_idx = i % n;

            while (!st.empty() && nums[st.top()] <= nums[current_idx]) {
                st.pop();
            }

            if (i < n) {
                if (!st.empty()) {
                    ans[current_idx] = nums[st.top()];
                }
            }

            st.push(current_idx);
        }

        return ans;
    }
};