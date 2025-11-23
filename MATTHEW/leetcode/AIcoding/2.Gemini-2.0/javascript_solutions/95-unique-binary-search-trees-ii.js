var generateTrees = function(n) {
    if (n === 0) return [];

    function generate(start, end) {
        if (start > end) return [null];

        const allTrees = [];

        for (let i = start; i <= end; i++) {
            const leftTrees = generate(start, i - 1);
            const rightTrees = generate(i + 1, end);

            for (let left of leftTrees) {
                for (let right of rightTrees) {
                    const root = new TreeNode(i);
                    root.left = left;
                    root.right = right;
                    allTrees.push(root);
                }
            }
        }

        return allTrees;
    }

    return generate(1, n);
};