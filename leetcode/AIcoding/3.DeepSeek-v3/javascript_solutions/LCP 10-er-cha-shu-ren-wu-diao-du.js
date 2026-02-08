var minimalExecTime = function(root) {
    const dfs = (node) => {
        if (!node) return [0, 0];
        const [leftTotal, leftParallel] = dfs(node.left);
        const [rightTotal, rightParallel] = dfs(node.right);
        const total = leftTotal + rightTotal + node.val;
        if (leftTotal < rightTotal) {
            const parallel = Math.min(leftTotal + rightParallel, (leftTotal + rightTotal) / 2);
            return [total, parallel];
        } else {
            const parallel = Math.min(rightTotal + leftParallel, (leftTotal + rightTotal) / 2);
            return [total, parallel];
        }
    };
    const [total, parallel] = dfs(root);
    return total - parallel;
};