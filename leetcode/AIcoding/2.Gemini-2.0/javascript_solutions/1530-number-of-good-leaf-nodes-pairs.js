var countPairs = function(root, distance) {
    let count = 0;

    function dfs(node) {
        if (!node) {
            return [];
        }

        if (!node.left && !node.right) {
            return [0];
        }

        const leftDistances = dfs(node.left);
        const rightDistances = dfs(node.right);

        for (const leftDist of leftDistances) {
            for (const rightDist of rightDistances) {
                if (leftDist + rightDist + 2 <= distance) {
                    count++;
                }
            }
        }

        const distances = [];
        for (const dist of leftDistances) {
            if (dist + 1 < distance) {
                distances.push(dist + 1);
            }
        }
        for (const dist of rightDistances) {
            if (dist + 1 < distance) {
                distances.push(dist + 1);
            }
        }

        return distances;
    }

    dfs(root);
    return count;
};