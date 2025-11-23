#include <vector>
#include <stack>
#include <map>

class Solution {
public:
    long long countSubarrays(std::vector<int>& nums, int k) {
        long long ans = 0;
        std::stack<int> st; // Stores indices of elements in a strictly decreasing sequence
        std::map<int, int> current_counts; // Stores counts of values for elements whose indices are in the stack

        for (int i = 0; i < nums.size(); ++i) {
            if (nums[i] > k) {
                // If current element is greater than k, it cannot be a boundary element.
                // Any subarray containing nums[i] or having nums[i] as a boundary is invalid.
                // So, we reset the stack and counts, starting a new "valid" segment.
                while (!st.empty()) {
                    st.pop();
                }
                current_counts.clear();
            } else {
                // Remove elements from stack that are strictly smaller than nums[i].
                // These elements cannot be 'l' for current 'i' (as 'r') because nums[i] would be a greater element in between.
                while (!st.empty() && nums[st.top()] < nums[i]) {
                    current_counts[nums[st.top()]]--;
                    if (current_counts[nums[st.top()]] == 0) {
                        current_counts.erase(nums[st.top()]);
                    }
                    st.pop();
                }

                // If st.top() (if exists) has value equal to nums[i]:
                // Let p = st.top(). We have nums[p] == nums[i].
                // For any index j such that p < j < i:
                //   - If nums[j] was popped by nums[i], it means nums[j] < nums[i].
                //   - If nums[j] is still on the stack between p and i, it must be that nums[j] >= nums[i]
                //     (to not be popped by nums[i]) AND nums[j] <= nums[p] (due to stack's decreasing property).
                //     Since nums[p] == nums[i], this implies nums[j] == nums[i].
                // Therefore, for any j in (p, i), nums[j] <= nums[i].
                // This means 'p' is a valid 'l' for the current 'i' (as 'r').
                // The count of nums[i] in current_counts map gives the number of such 'l's.
                if (!st.empty() && nums[st.top()] == nums[i]) {
                    ans += current_counts[nums[i]];
                }

                // Push current element's index onto stack and update its count.
                st.push(i);
                current_counts[nums[i]]++;
            }
        }

        return ans;
    }
};