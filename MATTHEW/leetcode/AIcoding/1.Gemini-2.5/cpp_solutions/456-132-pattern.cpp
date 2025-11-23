#include <vector>
#include <stack>
#include <climits> // For INT_MIN

class Solution {
public:
    bool find132pattern(std::vector<int>& nums) {
        int n = nums.size();
        if (n < 3) {
            return false;
        }

        // s3 will store the '3' in the 132 pattern (nums[k])
        // It's initialized to INT_MIN because we are looking for nums[i] < nums[k]
        int s3 = INT_MIN; 

        // The stack will store potential '2's (nums[j]) in decreasing order.
        // These are elements to the right of the current nums[i] being processed.
        std::stack<int> st; 

        // Iterate from right to left.
        // nums[i] is considered as the '1' in the 132 pattern.
        for (int i = n - 1; i >= 0; --i) {
            // If nums[i] (the '1') is less than s3 (the '3'), we found a 132 pattern.
            // The '2' (nums[j]) would be the element that caused s3 to be updated (i.e., st.top() before it was popped).
            // The indices constraint i < j < k is implicitly handled by iterating from right to left
            // and how s3 and stack elements are managed.
            if (nums[i] < s3) {
                return true;
            }

            // While the stack is not empty and the current nums[i] is greater than the top of the stack:
            // This means st.top() can be our '3' (nums[k]) and nums[i] could be our '2' (nums[j]).
            // We want to find the largest possible '3' (s3) that is still smaller than nums[i] (our current '2').
            while (!st.empty() && nums[i] > st.top()) {
                s3 = st.top(); // Update s3 to be the largest element popped so far that is a potential '3'
                st.pop();      // Pop it, as nums[i] is a better '2' candidate (or it's no longer a valid '2' for elements to its left)
            }

            // Push nums[i] onto the stack. It's a potential '2' (nums[j]) for elements to its left.
            // The stack maintains elements in decreasing order.
            st.push(nums[i]);
        }

        return false;
    }
};