var generateTrees = function(n) {
    if (n === 0) return [];

    const buildTrees = (start, end) => {
        if (start > end) return [null];
        const allTrees = [];

        for (let i = start; i <= end; i++) {
            const leftTrees = buildTrees(start, i - 1);
            const rightTrees = buildTrees(i + 1, end);

            for (const left of leftTrees) {
                for (const right of rightTrees) {
                    const root = new TreeNode(i);
                    root.left = left;
                    root.right = right;
                    allTrees.push(root);
                }
            }
        }

        return allTrees;
    };

    return buildTrees(1, n);
};