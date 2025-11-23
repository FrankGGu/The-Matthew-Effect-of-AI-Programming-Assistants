function markElementsOnArrayByPerformingQueries(nums, queries) {
    const result = [];
    const marked = new Set();

    for (const [index, value] of queries) {
        if (!marked.has(index)) {
            result.push(value);
            marked.add(index);
        }
    }

    return result;
}