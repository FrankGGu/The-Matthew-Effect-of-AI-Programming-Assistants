var allPossibleFBT = function(n) {
    const memo = new Map();

    function generate(count) {
        if (memo.has(count)) {
            return memo.get(count);
        }

        const result = [];
        if (count === 1) {
            result.push(new TreeNode(0));
        } else if (count % 2 === 1) {
            for (let i = 1; i < count; i += 2) {
                const j = count - 1 - i;
                const leftSubtrees = generate(i);
                const rightSubtrees = generate(j);

                for (const left of leftSubtrees) {
                    for (const right of rightSubtrees) {
                        const root = new TreeNode(0);
                        root.left = left;
                        root.right = right;
                        result.push(root);
                    }
                }
            }
        }

        memo.set(count, result);
        return result;
    }

    return generate(n);
};