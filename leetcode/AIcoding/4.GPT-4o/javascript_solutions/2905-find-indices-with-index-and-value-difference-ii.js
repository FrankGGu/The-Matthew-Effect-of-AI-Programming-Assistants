function findIndices(arr, diff) {
    const indices = {};
    const result = [];

    for (let i = 0; i < arr.length; i++) {
        const value = arr[i] - i;

        if (indices[value] !== undefined) {
            result.push([indices[value], i]);
        }

        indices[value + diff] = i;
    }

    return result;
}