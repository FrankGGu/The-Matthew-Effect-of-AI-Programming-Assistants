var removeBoxes = function(boxes) {
    const n = boxes.length;
    const dp = Array.from({ length: n }, () => 
        Array.from({ length: n }, () => 
            Array.from({ length: n }, () => 0)
        )
    );

    return helper(boxes, 0, n - 1, 0, dp);
};

function helper(boxes, i, j, k, dp) {
    if (i > j) return 0;
    if (dp[i][j][k] > 0) return dp[i][j][k];

    let res = (k + 1) * (k + 1) + helper(boxes, i + 1, j, 0, dp);

    for (let m = i + 1; m <= j; m++) {
        if (boxes[i] === boxes[m]) {
            res = Math.max(res, helper(boxes, i + 1, m - 1, 0, dp) + helper(boxes, m, j, k + 1, dp));
        }
    }

    dp[i][j][k] = res;
    return res;
}