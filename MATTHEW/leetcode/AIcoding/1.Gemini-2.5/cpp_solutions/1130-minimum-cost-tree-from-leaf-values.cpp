#include <vector>
#include <stack>
#include <algorithm> // For std::min
#include <limits>    // For std::numeric_limits

class Solution {
public:
    int mctFromLeafValues(std::vector<int>& arr) {
        int total_cost = 0;
        std::stack<int> st;
        // Push a sentinel value (infinity) to simplify boundary conditions.
        // This ensures that all elements in 'arr' will eventually be processed
        // by the 'while (st.top() <= x)' loop or the final 'while (st.size() > 2)' loop.
        st.push(std::numeric_limits<int>::max()); 

        for (int x : arr) {
            // While the current element 'x' is greater than or equal to the top of the stack,
            // it means 'st.top()' is a local minimum that can be combined.
            // We pop 'st.top()' (let's call it 'mid') and multiply it with its smaller neighbor.
            // The neighbors are the element currently at 'st.top()' (left) and 'x' (right).
            while (st.top() <= x) {
                int mid = st.top();
                st.pop();
                total_cost += mid * std::min(st.top(), x);
            }
            st.push(x);
        }

        // After iterating through all elements in 'arr', the stack contains
        // elements in decreasing order, along with the sentinel.
        // We continue to combine the remaining elements.
        // The loop runs as long as there are at least three elements:
        // sentinel, largest_left_max, largest_right_max.
        // We pop the smallest of these (which will be st.top()) and multiply it
        // with its only remaining neighbor (st.top() after pop).
        while (st.size() > 2) {
            int mid = st.top();
            st.pop();
            total_cost += mid * st.top();
        }

        return total_cost;
    }
};