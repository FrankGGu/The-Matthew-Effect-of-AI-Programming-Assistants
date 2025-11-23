var subtreeInversionSum = function(root) {
    let totalOverallInversions = 0;

    const mergeSortAndCount = (arr) => {
        if (arr.length <= 1) {
            return [0, arr];
        }

        const mid = Math.floor(arr.length / 2);
        const [leftInversions, leftArr] = mergeSortAndCount(arr.slice(0, mid));
        const [rightInversions, rightArr] = mergeSortAndCount(arr.slice(mid));

        let currentInversions = leftInversions + rightInversions;
        const mergedArr = [];
        let i = 0;
        let j = 0;

        while (i < leftArr.length && j < rightArr.length) {
            if (leftArr[i] <= rightArr[j]) {
                mergedArr.push(leftArr[i]);
                i++;
            } else {
                currentInversions += (leftArr.length - i);
                mergedArr.push(rightArr[j]);
                j++;
            }
        }

        while (i < leftArr.length) {
            mergedArr.push(leftArr[i]);
            i++;
        }
        while (j < rightArr.length) {
            mergedArr.push(rightArr[j]);
            j++;
        }

        return [currentInversions, mergedArr];
    };

    const dfs = (node) => {
        if (!node) {
            return [];
        }

        const leftValues = dfs(node.left);
        const rightValues = dfs(node.right);

        const valuesForCurrentSubtree = [...leftValues, node.val, ...rightValues];
        const [inversionsInThisSubtree, sortedValuesForThisSubtree] = mergeSortAndCount(valuesForCurrentSubtree);

        totalOverallInversions += inversionsInThisSubtree;

        return sortedValuesForThisSubtree;
    };

    dfs(root);
    return totalOverallInversions;
};