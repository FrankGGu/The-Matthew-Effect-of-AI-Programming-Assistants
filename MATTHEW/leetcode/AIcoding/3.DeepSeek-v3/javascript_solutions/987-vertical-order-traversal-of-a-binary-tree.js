var verticalTraversal = function(root) {
    if (!root) return [];

    const nodeInfos = [];

    function dfs(node, row, col) {
        if (!node) return;
        nodeInfos.push([col, row, node.val]);
        dfs(node.left, row + 1, col - 1);
        dfs(node.right, row + 1, col + 1);
    }

    dfs(root, 0, 0);

    nodeInfos.sort((a, b) => {
        if (a[0] !== b[0]) return a[0] - b[0];
        if (a[1] !== b[1]) return a[1] - b[1];
        return a[2] - b[2];
    });

    const result = [];
    let currentCol = null;
    let currentList = [];

    for (const [col, , val] of nodeInfos) {
        if (col !== currentCol) {
            if (currentList.length > 0) {
                result.push(currentList);
            }
            currentCol = col;
            currentList = [val];
        } else {
            currentList.push(val);
        }
    }

    if (currentList.length > 0) {
        result.push(currentList);
    }

    return result;
};