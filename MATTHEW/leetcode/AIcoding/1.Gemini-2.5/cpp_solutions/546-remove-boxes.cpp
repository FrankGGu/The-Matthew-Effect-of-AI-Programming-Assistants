#include <vector>
#include <cstring> // For memset
#include <algorithm> // For std::max

class Solution {
public:
    int memo[100][100][100];
    std::vector<int> B;

    int solve(int i, int j, int k) {
        if (i > j) {
            return 0;
        }
        if (memo[i][j][k] != -1) {
            return memo[i][j][k];
        }

        // Option 1: Remove boxes[j] along with k identical boxes to its right.
        // This block effectively has k+1 boxes of the same color.
        // Points from this removal: (k+1)*(k+1).
        // Then solve for the remaining subarray boxes[i...j-1] with no additional boxes to its right (k=0).
        int res = solve(i, j - 1, 0) + (k + 1) * (k + 1);

        // Option 2: Find a box boxes[m] (where i <= m < j) that has the same color as boxes[j].
        // We can choose to remove the segment boxes[m+1...j-1] first.
        // After removing boxes[m+1...j-1], boxes[m] and boxes[j] become adjacent.
        // Now, boxes[m] effectively has k+1 identical boxes to its right (boxes[j] and the original k boxes).
        // The total points would be the sum of points from removing boxes[i...m] with k+1 boxes to its right,
        // and points from removing boxes[m+1...j-1] (which are removed first, so k=0 for this segment).
        for (int m = i; m < j; ++m) {
            if (B[m] == B[j]) {
                res = std::max(res, solve(i, m, k + 1) + solve(m + 1, j - 1, 0));
            }
        }

        return memo[i][j][k] = res;
    }

    int removeBoxes(std::vector<int>& boxes) {
        B = boxes;

        // Initialize memo table with -1 to indicate uncomputed states.
        // -1 is a safe value for int arrays to represent uncomputed states, as scores are non-negative.
        for(int x = 0; x < 100; ++x) {
            for(int y = 0; y < 100; ++y) {
                for(int z = 0; z < 100; ++z) {
                    memo[x][y][z] = -1;
                }
            }
        }
        // Alternatively, using memset:
        // memset(memo, -1, sizeof(memo));

        // Start the recursive solution for the entire array (0 to N-1) with 0 additional identical boxes to its right.
        return solve(0, B.size() - 1, 0);
    }
};