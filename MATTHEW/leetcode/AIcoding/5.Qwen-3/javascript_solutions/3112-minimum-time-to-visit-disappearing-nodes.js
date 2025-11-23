function minTimeToVisitAllNodes(root, moveTime, stayTime) {
    let result = 0;

    function dfs(node) {
        if (!node) return 0;

        const left = dfs(node.left);
        const right = dfs(node.right);

        result += left + right + moveTime * 2;
        return Math.max(left, right) + stayTime;
    }

    dfs(root);
    return result;
}