#include <stdlib.h>
#include <string.h> // For memset

#define MAX_N 100

int memo[MAX_N][MAX_N][MAX_N];
int* global_boxes; // Pointer to the input boxes array

int max(int a, int b) {
    return a > b ? a : b;
}

int solve(int i, int j, int k) {
    if (i > j) {
        return 0;
    }
    if (memo[i][j][k] != -1) {
        return memo[i][j][k];
    }

    // Option 1: Remove boxes[j] and the k conceptually appended boxes.
    // This group consists of (k+1) boxes of the same color.
    // Points obtained = (k+1)*(k+1).
    // The remaining problem is to solve for boxes[i...j-1], and boxes[j-1]
    // now has 0 conceptually appended boxes to its right.
    int res = (k + 1) * (k + 1) + solve(i, j - 1, 0);

    // Option 2: Find an earlier box boxes[p] (where i <= p < j) that has the same color as boxes[j].
    // If we choose to remove the segment boxes[p+1...j-1] first,
    // then boxes[p] and boxes[j] become effectively adjacent.
    // Now, boxes[p] is conceptually followed by boxes[j] AND the original k boxes.
    // So, boxes[p] is followed by (k+1) boxes of its own color.
    // Points from removing boxes[p+1...j-1]: solve(p+1, j-1, 0)
    // The remaining problem is to solve for boxes[i...p], with k+1 conceptually appended boxes.
    for (int p = j - 1; p >= i; p--) {
        if (global_boxes[p] == global_boxes[j]) {
            res = max(res, solve(p + 1, j - 1, 0) + solve(i, p, k + 1));
        }
    }

    return memo[i][j][k] = res;
}

int removeBoxes(int* boxes, int boxesSize) {
    // Initialize memoization table with -1 to indicate uncomputed states.
    // sizeof(memo) works because memo is a global static array.
    memset(memo, -1, sizeof(memo));

    // Store the input boxes array pointer globally for easy access in the recursive function.
    global_boxes = boxes;

    // Start the recursion from the entire array (indices 0 to boxesSize-1),
    // with 0 conceptually appended boxes to the right of boxes[boxesSize-1].
    return solve(0, boxesSize - 1, 0);
}