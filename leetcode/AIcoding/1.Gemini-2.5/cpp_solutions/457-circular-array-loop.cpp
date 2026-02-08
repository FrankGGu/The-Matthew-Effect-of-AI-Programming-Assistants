#include <vector>
#include <numeric>

class Solution {
public:
    // Helper function to get the next index in the circular array.
    // Returns -1 if the move is invalid (e.g., direction change or points to an already invalidated node).
    int get_next_idx(int current_idx, const std::vector<int>& nums, int n, bool is_forward) {
        // If current_idx itself has been marked as 0, it's invalid to step from it.
        // This handles cases where a pointer lands on an already invalidated node.
        if (nums[current_idx] == 0) {
            return -1;
        }

        // Check if the direction of the current step is consistent with the path's overall direction.
        bool current_step_is_forward = nums[current_idx] > 0;
        if (current_step_is_forward != is_forward) {
            return -1; // Direction change, invalid path.
        }

        // Calculate the next index.
        int next_idx = (current_idx + nums[current_idx]);
        // Handle negative results of modulo in C++ to ensure a positive index.
        next_idx = (next_idx % n + n) % n;

        return next_idx;
    }

    bool circularArrayLoop(std::vector<int>& nums) {
        int n = nums.size();
        if (n <= 1) {
            return false;
        }

        for (int i = 0; i < n; ++i) {
            if (nums[i] == 0) { 
                // This index has been visited and marked as invalid (part of a path that didn't form a valid loop).
                // Skip it to avoid re-processing.
                continue;
            }

            // Determine the direction for the current path starting from 'i'.
            bool is_forward = nums[i] > 0;
            int slow = i;
            int fast = i;

            // Use Floyd's cycle-finding algorithm (fast and slow pointers).
            while (true) {
                slow = get_next_idx(slow, nums, n, is_forward);
                if (slow == -1) break; // Path invalid or direction changed.

                fast = get_next_idx(fast, nums, n, is_forward);
                if (fast == -1) break; // Path invalid or direction changed.

                fast = get_next_idx(fast, nums, n, is_forward);
                if (fast == -1) break; // Path invalid or direction changed.

                if (slow == fast) {
                    // Cycle detected. Now check if its length is greater than 1.
                    // A cycle of length 1 occurs if nums[slow] is a multiple of n,
                    // causing (slow + nums[slow]) % n == slow.
                    if (nums[slow] % n != 0) { 
                        return true; // Valid cycle found (length > 1).
                    } else {
                        // This is a cycle of length 1. Break and mark path as invalid.
                        break;
                    }
                }
            }

            // If the loop broke (no valid cycle or a length 1 cycle was found),
            // mark all nodes in the path starting from 'i' as 0 to avoid re-processing.
            // This is crucial for efficiency and correctness.
            int current_path_node = i;
            while (nums[current_path_node] != 0) { 
                // Store the current node's index temporarily before calculating the next step
                // and marking the current node as 0.
                int temp_current_path_node = current_path_node;
                current_path_node = get_next_idx(temp_current_path_node, nums, n, is_forward);
                nums[temp_current_path_node] = 0; // Mark the node we just left as 0.

                if (current_path_node == -1) { 
                    // If the next step was invalid (e.g., direction change or hit a 0), stop marking this path.
                    break;
                }
            }
        }

        return false; // No valid circular array loop found.
    }
};