var minimumAbsDifference = function(arr) {
    arr.sort((a, b) => a - b);
    let minDiff = Infinity;
    for (let i = 0; i < arr.length - 1; i++) {
        minDiff = Math.min(minDiff, arr[i + 1] - arr[i]);
    }
    let result = [];
    for (let i = 0; i < arr.length - 1; i++) {
        if (arr[i + 1] - arr[i] === minDiff) {
            result.push([arr[i], arr[i + 1]]);
        }
    }
    return result;
};