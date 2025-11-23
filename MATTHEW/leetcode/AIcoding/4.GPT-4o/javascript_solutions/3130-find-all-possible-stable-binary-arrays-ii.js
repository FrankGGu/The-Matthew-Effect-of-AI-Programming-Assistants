var findAllPossibleFBT = function(N) {
    if (N % 2 === 0) return [];
    const memo = new Map();

    const helper = (n) => {
        if (n in memo) return memo.get(n);
        if (n === 1) return [new TreeNode(0)];
        const res = [];
        for (let left = 1; left < n; left += 2) {
            const leftTrees = helper(left);
            const rightTrees = helper(n - 1 - left);
            for (const l of leftTrees) {
                for (const r of rightTrees) {
                    const root = new TreeNode(0);
                    root.left = l;
                    root.right = r;
                    res.push(root);
                }
            }
        }
        memo.set(n, res);
        return res;
    };

    return helper(N);
};

function TreeNode(val) {
    this.val = val;
    this.left = this.right = null;
}