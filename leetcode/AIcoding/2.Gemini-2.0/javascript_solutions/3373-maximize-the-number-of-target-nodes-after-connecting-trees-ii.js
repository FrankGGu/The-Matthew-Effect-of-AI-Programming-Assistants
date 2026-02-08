var maximizeTheNumberOfTargetNodes = function(trees, root) {
    const map = new Map();
    for (const tree of trees) {
        map.set(tree.val, tree);
    }

    const memo = new Map();

    function dfs(node) {
        if (!node) {
            return 0;
        }

        if (memo.has(node)) {
            return memo.get(node);
        }

        let maxTargets = 0;

        // Option 1: Don't connect anything to this node
        maxTargets = Math.max(maxTargets, dfs(node.left) + dfs(node.right));

        // Option 2: Try connecting other trees to this node
        if (map.has(node.val)) {
            const tree = map.get(node.val);
            map.delete(node.val);

            let leftTargets = 0;
            if (tree.left) {
                leftTargets = dfs(tree.left) + 1;
            }

            let rightTargets = 0;
            if (tree.right) {
                rightTargets = dfs(tree.right) + 1;
            }

            maxTargets = Math.max(maxTargets, leftTargets + rightTargets);

            if(tree.val !== root.val){
              map.set(tree.val, tree);
            }

        }

        memo.set(node, maxTargets);
        return maxTargets;
    }

    return dfs(root);
};