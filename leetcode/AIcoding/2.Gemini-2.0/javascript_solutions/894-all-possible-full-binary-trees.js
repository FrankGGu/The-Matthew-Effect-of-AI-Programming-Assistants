var allPossibleFBT = function(n) {
    if (n % 2 === 0) return [];
    if (n === 1) return [new TreeNode(0)];

    const memo = new Map();

    function generateTrees(n) {
        if (memo.has(n)) return memo.get(n);
        if (n === 1) return [new TreeNode(0)];

        const result = [];
        for (let i = 1; i < n; i += 2) {
            const leftTrees = generateTrees(i);
            const rightTrees = generateTrees(n - 1 - i);

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

    return generateTrees(n);
};