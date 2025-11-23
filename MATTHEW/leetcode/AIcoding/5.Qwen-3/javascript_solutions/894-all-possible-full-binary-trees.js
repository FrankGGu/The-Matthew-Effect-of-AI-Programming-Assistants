var allPossibleFBT = function(n) {
    const memo = {};

    function helper(n) {
        if (n in memo) return memo[n];

        const result = [];

        if (n === 1) {
            result.push(new TreeNode(0));
            return result;
        }

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

        memo[n] = result;
        return result;
    }

    return helper(n);
};