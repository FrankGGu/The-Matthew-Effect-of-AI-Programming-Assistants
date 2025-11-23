var finalArrayAfterOperations = function(nums, k, queries) {
    let n = nums.length;
    let result = nums.slice();

    for (let i = 0; i < k; i++) {
        let newResult = [];
        for (let j = 0; j < n; j++) {
            newResult.push(result[j] * queries[i % queries.length]);
        }
        result = newResult;
    }

    return result;
};