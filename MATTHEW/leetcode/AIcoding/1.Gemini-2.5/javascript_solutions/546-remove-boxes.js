var removeBoxes = function(boxes) {
    const n = boxes.length;
    // memo[i][j][k] stores the maximum points from boxes[i...j]
    // where there are k boxes of the same color as boxes[i]
    // immediately to the left of boxes[i] (conceptually, that will be removed together with boxes[i]).
    const memo = Array(n).fill(0).map(() =>
        Array(n).fill(0).map(() =>
            Array(n).fill(-1)
        )
    );

    function dp(i, j, k) {
        if (i > j) {
            return 0;
        }
        if (memo[i][j][k] !== -1) {
            return memo[i][j][k];
        }

        // Option 1: Remove boxes[i] along with the k preceding boxes of the same color.
        // This forms a block of (k+1) boxes.
        // The remaining problem is dp(i+1, j, 0) because boxes[i+1] starts a new potential block.
        let res = (k + 1) * (k + 1) + dp(i + 1, j, 0);

        // Option 2: Find a boxes[m] such that boxes[m] == boxes[i] (and m > i).
        // Remove the subarray boxes[i+1 ... m-1] first.
        // Then, combine boxes[i] with boxes[m] (and the k original preceding boxes).
        for (let m = i + 1; m <= j; m++) {
            if (boxes[m] === boxes[i]) {
                // Points from removing boxes[i+1 ... m-1] (with no preceding boxes of same color)
                // Plus points from combining boxes[i] with boxes[m].
                // When we combine boxes[i] with boxes[m], boxes[m] effectively has (k+1)
                // boxes of the same color to its left (boxes[i] and the k original ones).
                res = Math.max(res, dp(i + 1, m - 1, 0) + dp(m, j, k + 1));
            }
        }

        memo[i][j][k] = res;
        return res;
    }

    return dp(0, n - 1, 0);
};