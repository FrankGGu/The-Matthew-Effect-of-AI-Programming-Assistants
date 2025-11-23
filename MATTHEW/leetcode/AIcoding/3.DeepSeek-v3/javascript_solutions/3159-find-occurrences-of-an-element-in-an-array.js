var occurrencesOfElement = function(arr, queries, x) {
    let indices = [];
    for (let i = 0; i < arr.length; i++) {
        if (arr[i] === x) {
            indices.push(i);
        }
    }
    let result = [];
    for (let query of queries) {
        if (query <= indices.length) {
            result.push(indices[query - 1]);
        } else {
            result.push(-1);
        }
    }
    return result;
};