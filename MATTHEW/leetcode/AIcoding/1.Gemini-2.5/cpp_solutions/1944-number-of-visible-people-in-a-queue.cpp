#include <vector>
#include <stack>
#include <algorithm>

class Solution {
public:
    std::vector<int> canSeePersonsCount(std::vector<int>& heights) {
        int n = heights.size();
        std::vector<int> ans(n);
        std::stack<int> st; // Stores heights in a monotonic decreasing order from bottom to top

        // Iterate from right to left
        for (int i = n - 1; i >= 0; --i) {
            int current_person_height = heights[i];
            int count = 0;

            // Pop elements from the stack that are shorter than the current person's height.
            // These are the people the current person can see.
            while (!st.empty() && st.top() < current_person_height) {
                count++;
                st.pop();
            }

            // If the stack is not empty after popping, it means the top element
            // is taller than or equal to the current person's height.
            // The current person can see this person, and this person blocks
            // visibility to any further people on the stack.
            if (!st.empty()) {
                count++;
            }

            ans[i] = count;
            st.push(current_person_height);
        }

        return ans;
    }
};