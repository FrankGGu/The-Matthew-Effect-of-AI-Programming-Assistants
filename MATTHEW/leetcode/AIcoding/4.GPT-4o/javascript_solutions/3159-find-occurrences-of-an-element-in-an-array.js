var countOccurrences = function(arr, target) {
    return arr.reduce((count, num) => count + (num === target ? 1 : 0), 0);
};