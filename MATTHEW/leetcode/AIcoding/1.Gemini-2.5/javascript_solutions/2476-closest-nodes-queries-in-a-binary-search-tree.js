var closestNodes = function(root, queries) {
    const sortedVals = [];

    function inorderTraversal(node) {
        if (!node) {
            return;
        }
        inorderTraversal(node.left);
        sortedVals.push(node.val);
        inorderTraversal(node.right);
    }

    inorderTraversal(root);

    const results = [];

    for (const query of queries) {
        let minVal = -1;
        let maxVal = -1;

        let low = 0;
        let high = sortedVals.length - 1;
        while (low <= high) {
            const mid = Math.floor((low + high) / 2);
            if (sortedVals[mid] <= query) {
                minVal = sortedVals[mid];
                low = mid + 1;
            } else {
                high = mid - 1;
            }
        }

        low = 0;
        high = sortedVals.length - 1;
        while (low <= high) {
            const mid = Math.floor((low + high) / 2);
            if (sortedVals[mid] >= query) {
                maxVal = sortedVals[mid];
                high = mid - 1;
            } else {
                low = mid + 1;
            }
        }
        results.push([minVal, maxVal]);
    }

    return results;
};