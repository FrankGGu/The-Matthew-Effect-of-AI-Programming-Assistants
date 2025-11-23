var removeBoxes = function(boxes) {
    const n = boxes.length;
    const memo = Array(n).fill(null).map(() => Array(n).fill(null).map(() => Array(n).fill(null)));

    function dp(l, r, k) {
        if (l > r) {
            return 0;
        }

        if (memo[l][r][k] !== null) {
            return memo[l][r][k];
        }

        while (l < r && boxes[r] === boxes[r - 1]) {
            r--;
            k++;
        }

        let result = dp(l, r - 1, 0) + (k + 1) * (k + 1);

        for (let i = l; i < r; i++) {
            if (boxes[i] === boxes[r]) {
                result = Math.max(result, dp(l, i, k + 1) + dp(i + 1, r - 1, 0));
            }
        }

        memo[l][r][k] = result;
        return result;
    }

    return dp(0, n - 1, 0);
};