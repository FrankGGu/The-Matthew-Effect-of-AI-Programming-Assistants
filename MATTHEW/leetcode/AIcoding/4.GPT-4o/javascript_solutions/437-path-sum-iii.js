var pathSum = function(root, targetSum) {
    let count = 0;
    const map = new Map();

    const dfs = (node, currSum) => {
        if (!node) return;

        currSum += node.val;
        if (currSum === targetSum) count++;

        count += map.get(currSum - targetSum) || 0;
        map.set(currSum, (map.get(currSum) || 0) + 1);

        dfs(node.left, currSum);
        dfs(node.right, currSum);

        map.set(currSum, map.get(currSum) - 1);
    };

    dfs(root, 0);
    return count;
};