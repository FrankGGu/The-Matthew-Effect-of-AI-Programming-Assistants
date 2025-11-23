var findLargestElement = function(arr) {
    let maxElement = Math.max(...arr);
    while (arr.length > 1) {
        arr.sort((a, b) => a - b);
        arr[0] += arr[1];
        arr.splice(1, 1);
    }
    return Math.max(maxElement, arr[0]);
};