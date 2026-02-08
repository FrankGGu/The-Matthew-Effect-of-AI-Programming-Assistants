var countHighestScoreNodes = function(root) {
    let maxScore = 0;
    let count = 0;
    const n = countNodes(root);

    function countNodes(node) {
        if (!node) return 0;
        return 1 + countNodes(node.left) + countNodes(node.right);
    }

    function calculateScore(node) {
        if (!node) return;

        let leftCount = node.left ? countNodes(node.left) : 0;
        let rightCount = node.right ? countNodes(node.right) : 0;

        let score = 1;
        if (leftCount > 0) score *= leftCount;
        if (rightCount > 0) score *= rightCount;
        if (leftCount + rightCount < n) score *= (n - leftCount - rightCount - 1);

        if (score > maxScore) {
            maxScore = score;
            count = 1;
        } else if (score === maxScore) {
            count++;
        }

        calculateScore(node.left);
        calculateScore(node.right);
    }

    calculateScore(root);
    return count;
};