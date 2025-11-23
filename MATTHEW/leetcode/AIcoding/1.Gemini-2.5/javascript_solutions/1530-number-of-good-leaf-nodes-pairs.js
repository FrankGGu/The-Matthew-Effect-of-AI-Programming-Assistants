var countPairs = function(root, distance) {
    let goodPairsCount = 0;

    const dfs = (node) => {
        if (!node) {
            return [];
        }

        if (!node.left && !node.right) {
            return [0];
        }

        const leftDistances = dfs(node.left);
        const rightDistances = dfs(node.right);

        for (const ld of leftDistances) {
            for (const rd of rightDistances) {
                if (ld + 1 + rd + 1 <= distance) {
                    goodPairsCount++;
                }
            }
        }

        const currentToLeafDistances = [];
        for (const ld of leftDistances) {
            if (ld + 1 < distance) {
                currentToLeafDistances.push(ld + 1);
            }
        }
        for (const rd of rightDistances) {
            if (rd + 1 < distance) {
                currentToLeafDistances.push(rd + 1);
            }
        }
        return currentToLeafDistances;
    };

    dfs(root);
    return goodPairsCount;
};