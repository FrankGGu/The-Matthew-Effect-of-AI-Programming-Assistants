var maxJumps = function(arr, d) {
    const n = arr.length;
    const dp = new Array(n).fill(0);

    function dfs(i) {
        if (dp[i] !== 0) {
            return dp[i];
        }

        let maxJump = 1;

        for (let j = i + 1; j <= Math.min(i + d, n - 1); j++) {
            if (arr[j] >= arr[i]) {
                break;
            }
            maxJump = Math.max(maxJump, 1 + dfs(j));
        }

        for (let j = i - 1; j >= Math.max(i - d, 0); j--) {
            if (arr[j] >= arr[i]) {
                break;
            }
            maxJump = Math.max(maxJump, 1 + dfs(j));
        }

        dp[i] = maxJump;
        return maxJump;
    }

    let result = 0;
    for (let i = 0; i < n; i++) {
        result = Math.max(result, dfs(i));
    }

    return result;
};