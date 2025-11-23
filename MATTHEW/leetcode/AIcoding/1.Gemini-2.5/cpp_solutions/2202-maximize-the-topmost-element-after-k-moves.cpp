#include <vector>
#include <algorithm> // For std::max and std::max_element

class Solution {
public:
    int maximizeTheTopmostElement(std::vector<int>& nums, int k) {
        int n = nums.size();

        // Case 1: No elements in the array (problem constraints say n >= 1, but good to be robust)
        // if (n == 0) {
        //     return -1;
        // }

        // Case 2: No moves allowed
        if (k == 0) {
            return nums[0];
        }

        // Case 3: Only one element in the array
        if (n == 1) {
            // If k is odd, we remove nums[0] and the stack becomes empty.
            // If k is even, we remove nums[0] (1 move), then add it back (1 move).
            // The remaining k-2 moves (which is even) can be spent by removing and adding
            // an element (which doesn't exist here, but the operation is defined as such)
            // without affecting nums[0] being on top. So nums[0] is topmost.
            return (k % 2 == 1) ? -1 : nums[0];
        }

        // Case 4: k is equal to n
        // We remove all n elements. The stack becomes empty. No topmost element.
        if (k == n) {
            return -1;
        }

        // General Case: n > 1, k > 0, k != n
        // We need to find the maximum among two types of candidates:

        // Candidate Type A: Elements that are removed and then put back on top.
        // To make nums[i] topmost by removing it and putting it back:
        // 1. Remove i elements (nums[0]...nums[i-1]). Cost: i moves.
        // 2. Remove nums[i]. Cost: 1 move. nums[i] is now in hand. Total i+1 moves.
        // 3. Add nums[i] back to the top. Cost: 1 move. nums[i] is now on top. Total i+2 moves.
        // Remaining moves: k - (i+2). These must be an even non-negative number.
        // So, i <= k-2 AND (k - i - 2) % 2 == 0, which simplifies to (k - i) % 2 == 0.
        // This is possible for nums[i] where 0 <= i < n and i <= k-2.
        int max_val = -1; // Initialize with -1 as nums[i] >= 0

        for (int i = 0; i < n && i <= k - 2; ++i) {
            if ((k - i) % 2 == 0) {
                max_val = std::max(max_val, nums[i]);
            }
        }

        // Candidate Type B: The element nums[k] itself.
        // To make nums[k] topmost:
        // 1. Remove k elements (nums[0]...nums[k-1]). Cost: k moves.
        // 2. nums[k] is now on top. 0 moves remaining.
        // This is possible if k < n.
        if (k < n) {
            max_val = std::max(max_val, nums[k]);
        }

        return max_val;
    }
};