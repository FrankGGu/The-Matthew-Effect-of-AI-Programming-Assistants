var kthSmallestPath = function(destination, horizontal, k) {
    let vertical = destination - horizontal;
    let ans = "";
    let dp = Array(vertical + horizontal + 1).fill(null).map(() => Array(horizontal + 1).fill(0));

    function combinations(n, k) {
        if (k < 0 || k > n) {
            return 0;
        }
        if (k === 0 || k === n) {
            return 1;
        }
        if (k > n / 2) {
            k = n - k;
        }
        if(dp[n][k] !== 0) return dp[n][k];
        dp[n][k] = combinations(n - 1, k - 1) + combinations(n - 1, k);
        return dp[n][k];
    }

    while (vertical > 0 || horizontal > 0) {
        if (horizontal > 0) {
            let comb = combinations(vertical + horizontal - 1, vertical);
            if (k <= comb) {
                ans += "H";
                horizontal--;
            } else {
                ans += "V";
                vertical--;
                k -= comb;
            }
        } else {
            ans += "V";
            vertical--;
        }
    }

    return ans;
};