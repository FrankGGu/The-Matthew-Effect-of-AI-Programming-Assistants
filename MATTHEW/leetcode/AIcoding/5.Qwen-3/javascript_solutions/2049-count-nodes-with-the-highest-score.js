function countHighestScoreNodes(root) {
    let maxScore = 0;
    let count = 0;

    function dfs(node) {
        if (!node) return 0;
        const left = dfs(node.left);
        const right = dfs(node.right);
        const total = left + right + 1;
        const score = (left === 0 ? 1 : left) * (right === 0 ? 1 : right);
        if (score > maxScore) {
            maxScore = score;
            count = 1;
        } else if (score === maxScore) {
            count++;
        }
        return total;
    }

    dfs(root);
    return count;
}