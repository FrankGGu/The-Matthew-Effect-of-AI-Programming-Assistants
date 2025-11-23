#include <vector>
#include <algorithm> // For std::max

class Solution {
public:
    int arrayNesting(std::vector<int>& nums) {
        int n = nums.size();
        int max_len = 0;

        for (int i = 0; i < n; ++i) {
            // If nums[i] is not 'n' (our sentinel value), it means
            // this element 'i' has not been visited as part of any cycle yet.
            // The value at nums[i] indicates the next index in the sequence.
            // If nums[i] == n, it means the index 'i' was previously set to n,
            // indicating it's part of an already processed cycle.
            if (nums[i] != n) {
                int current_index = i; // Start the traversal from index 'i'
                int current_len = 0;

                // Traverse the cycle starting from 'current_index'
                // The loop continues as long as 'current_index' has not been visited
                // in the current or any previous cycle. An index `k` is considered
                // visited if `nums[k]` has been changed to `n`.
                while (nums[current_index] != n) {
                    int next_index = nums[current_index]; // Get the next index in the sequence
                    nums[current_index] = n; // Mark current_index as visited by changing its value
                    current_index = next_index; // Move to the next index
                    current_len++;
                }
                max_len = std::max(max_len, current_len);
            }
        }
        return max_len;
    }
};