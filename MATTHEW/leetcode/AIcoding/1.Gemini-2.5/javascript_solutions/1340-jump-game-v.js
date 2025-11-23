var maxJumps = function(arr, d) {
    const n = arr.length;
    const dp = new Array(n).fill(0);

    function dfs(i) {
        if (dp[i] !== 0) {
            return dp[i];
        }

        let max_jumps_from_i = 1;

        // Explore jumps to the right
        for (let j = i + 1; j < n && j <= i + d; j++) {
            if (arr[j] >= arr[i]) {
                break;
            }
            max_jumps_from_i = Math.max(max_jumps_from_i, 1 + dfs(j));
        }

        // Explore jumps to the left
        for (let j = i - 1; j >= 0 && j >= i - d; j--) {
            if (arr[j] >= arr[i]) {
                break;
            }
            max_jumps_from_i = Math.max(max_jumps_from_i, 1 + dfs(j));
        }

        dp[i] = max_jumps_from_i;
        return max_jumps_from_i;
    }

    let overall_max_jumps = 0;
    for (let i = 0; i < n; i++) {
        overall_max_jumps = Math.max(overall_max_jumps, dfs(i));
    }

    return overall_max_jumps;
};