var gridGame = function(grid) {
    let n = grid[0].length;
    let pre1 = new Array(n).fill(0);
    let pre2 = new Array(n).fill(0);
    pre1[0] = grid[0][0];
    pre2[0] = grid[1][0];
    for(let i = 1; i < n; i++){
        pre1[i] = pre1[i-1] + grid[0][i];
        pre2[i] = pre2[i-1] + grid[1][i];
    }

    let ans = Infinity;
    for(let i = 0; i < n; i++){
        let top = (i == n - 1) ? 0 : pre1[n-1] - pre1[i];
        let bottom = (i == 0) ? 0 : pre2[i-1];
        ans = Math.min(ans, Math.max(top, bottom));
    }
    return ans;
};