var longestZigZag = function(root) {
    let maxLen = 0;

    function dfs(node) {
        if (!node) {
            return [-1, -1]; 
        }

        let leftRes = dfs(node.left);
        let rightRes = dfs(node.right);

        let goLeftFromNode = 1 + rightRes[1];
        let goRightFromNode = 1 + leftRes[0];

        maxLen = Math.max(maxLen, goLeftFromNode, goRightFromNode);

        return [goLeftFromNode, goRightFromNode];
    }

    dfs(root);
    return maxLen;
};