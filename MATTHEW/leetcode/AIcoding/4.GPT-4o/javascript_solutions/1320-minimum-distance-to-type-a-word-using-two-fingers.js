var minimumDistance = function(word) {
    const n = word.length;
    const dp = Array.from({ length: n + 1 }, () => Array.from({ length: n + 1 }, () => Infinity));
    for (let i = 0; i <= n; i++) {
        dp[i][i] = 0;
    }

    const pos = new Array(26).fill(0).map(() => [0, 0]);
    const getDistance = (a, b) => {
        const ax = pos[a][0], ay = pos[a][1];
        const bx = pos[b][0], by = pos[b][1];
        return Math.abs(ax - bx) + Math.abs(ay - by);
    };

    for (let i = 0; i < 26; i++) {
        const x = Math.floor(i / 6);
        const y = i % 6;
        pos[i] = [x, y];
    }

    let result = Infinity;

    const dfs = (left, right, index) => {
        if (index === n) {
            result = Math.min(result, dp[left][right]);
            return;
        }
        const curr = word.charCodeAt(index) - 'A'.charCodeAt(0);
        if (left === -1) {
            dp[curr][right] = Math.min(dp[curr][right], dfs(curr, right, index + 1) + (right === -1 ? 0 : getDistance(curr, right)));
        } else if (right === -1) {
            dp[left][curr] = Math.min(dp[left][curr], dfs(left, curr, index + 1) + (left === -1 ? 0 : getDistance(left, curr)));
        } else {
            dp[left][curr] = Math.min(dp[left][curr], dfs(left, curr, index + 1) + getDistance(left, curr));
            dp[curr][right] = Math.min(dp[curr][right], dfs(curr, right, index + 1) + getDistance(curr, right));
        }
    };

    dfs(-1, -1, 0);
    return result;
};