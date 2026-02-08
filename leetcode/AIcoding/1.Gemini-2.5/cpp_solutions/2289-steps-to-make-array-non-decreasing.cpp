#include <vector>
#include <stack>
#include <algorithm>
#include <utility>

class Solution {
public:
    int totalSteps(std::vector<int>& nums) {
        int n = nums.size();
        if (n <= 1) {
            return 0;
        }

        std::stack<std::pair<int, int>> st;
        int max_steps = 0;

        for (int num : nums) {
            int current_steps = 0;
            while (!st.empty() && st.top().first <= num) {
                current_steps = std::max(current_steps, st.top().second);
                st.pop();
            }

            int steps_for_current = 0;
            if (!st.empty()) {
                steps_for_current = current_steps + 1;
            }

            max_steps = std::max(max_steps, steps_for_current);
            st.push({num, steps_for_current});
        }

        return max_steps;
    }
};