var getDistances = function(arr) {
    const n = arr.length;
    const indexMap = new Map();
    const result = new Array(n).fill(0);

    for (let i = 0; i < n; i++) {
        if (!indexMap.has(arr[i])) {
            indexMap.set(arr[i], []);
        }
        indexMap.get(arr[i]).push(i);
    }

    for (const indices of indexMap.values()) {
        const totalCount = indices.length;
        const totalSum = indices.reduce((a, b) => a + b, 0);

        for (let i = 0; i < totalCount; i++) {
            const currentIndex = indices[i];
            const leftCount = i;
            const rightCount = totalCount - i - 1;
            const leftSum = totalSum - (totalCount - leftCount) * currentIndex;
            const rightSum = (currentIndex * rightCount) - (totalSum - (i === totalCount - 1 ? 0 : indices[i + 1]));
            result[currentIndex] = leftSum + rightSum;
        }
    }

    return result;
};