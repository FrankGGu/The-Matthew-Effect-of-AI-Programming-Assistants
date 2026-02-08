var allPossibleFBT = function(n) {
    if (n % 2 === 0) return [];
    const memo = new Map();

    function helper(n) {
        if (memo.has(n)) return memo.get(n);
        if (n === 1) {
            const node = new TreeNode(0);
            return [node];
        }

        const result = [];
        for (let i = 1; i < n; i += 2) {
            const leftTrees = helper(i);
            const rightTrees = helper(n - 1 - i);

            for (const left of leftTrees) {
                for (const right of rightTrees) {
                    const root = new TreeNode(0);
                    root.left = left;
                    root.right = right;
                    result.push(root);
                }
            }
        }
        memo.set(n, result);
        return result;
    }

    return helper(n);
};