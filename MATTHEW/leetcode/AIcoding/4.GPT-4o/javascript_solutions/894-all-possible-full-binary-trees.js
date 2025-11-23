var allPossibleFBT = function(N) {
    if (N % 2 === 0) return [];
    const dp = new Array(N + 1).fill(0).map(() => []);
    dp[1] = [new TreeNode(0)];

    for (let n = 3; n <= N; n += 2) {
        for (let left = 1; left < n; left += 2) {
            const right = n - 1 - left;
            for (const leftTree of dp[left]) {
                for (const rightTree of dp[right]) {
                    const root = new TreeNode(0);
                    root.left = leftTree;
                    root.right = rightTree;
                    dp[n].push(root);
                }
            }
        }
    }
    return dp[N];
};

function TreeNode(val) {
    this.val = val;
    this.left = this.right = null;
}