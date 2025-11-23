#include <vector>
#include <algorithm>

class Solution {
public:
    int minMoves(std::vector<int>& nums, int limit) {
        int n = nums.size();
        // diff array to store changes in moves for different target sums
        // The maximum possible sum is limit + limit = 2 * limit.
        // The minimum possible sum is 1 + 1 = 2.
        // We need indices from 2 up to 2*limit.
        // diff[k] stores the change in total moves when moving from target sum k-1 to k.
        std::vector<int> diff(2 * limit + 2, 0);

        // Iterate through pairs (nums[i], nums[n-1-i])
        for (int i = 0; i < n / 2; ++i) {
            int a = nums[i];
            int b = nums[n - 1 - i];

            // Ensure a <= b for consistent logic
            if (a > b) {
                std::swap(a, b);
            }

            // For a single pair (a, b) with a <= b, the number of moves required for a target sum S:
            // 1. S in [2, a]: 2 moves (both a and b must be changed)
            // 2. S in [a+1, a+b-1]: 1 move (one of a or b can be changed)
            // 3. S = a+b: 0 moves (no changes needed)
            // 4. S in [a+b+1, b+limit]: 1 move (one of a or b can be changed)
            // 5. S in [b+limit+1, 2*limit]: 2 moves (both a and b must be changed)

            // We use a difference array to efficiently calculate the total moves for each S.
            // Initialize `current_total_moves` to `n` (which is `(n/2) * 2`), representing
            // the worst case where every pair needs 2 moves.
            // The `diff` array then tracks how this `current_total_moves` changes.

            // When S increases:
            // - At S = a+1: The cost for this pair changes from 2 to 1 (decreases by 1).
            diff[a + 1] -= 1;
            // - At S = a+b: The cost for this pair changes from 1 to 0 (decreases by 1).
            diff[a + b] -= 1;
            // - At S = a+b+1: The cost for this pair changes from 0 to 1 (increases by 1).
            diff[a + b + 1] += 1;
            // - At S = b+limit+1: The cost for this pair changes from 1 to 2 (increases by 1).
            diff[b + limit + 1] += 1;
        }

        // Calculate actual total moves for each sum S by accumulating diff values
        // Initial total moves for any sum S: n (which is N/2 pairs * 2 moves/pair)
        int current_total_moves = n; 
        int min_overall_moves = n; // Initialize with the worst-case scenario

        // Iterate through all possible target sums S from 2 to 2*limit
        for (int s = 2; s <= 2 * limit; ++s) {
            current_total_moves += diff[s];
            min_overall_moves = std::min(min_overall_moves, current_total_moves);
        }

        return min_overall_moves;
    }
};