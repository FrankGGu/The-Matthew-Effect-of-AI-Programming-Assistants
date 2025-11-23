function minimumAbsoluteDifferenceQueries(arr, queries) {
    const n = arr.length;
    const result = [];

    for (const [l, r] of queries) {
        const subArr = arr.slice(l, r + 1);
        subArr.sort((a, b) => a - b);
        let minDiff = Infinity;
        for (let i = 0; i < subArr.length - 1; i++) {
            minDiff = Math.min(minDiff, subArr[i + 1] - subArr[i]);
        }
        result.push(minDiff);
    }

    return result;
}