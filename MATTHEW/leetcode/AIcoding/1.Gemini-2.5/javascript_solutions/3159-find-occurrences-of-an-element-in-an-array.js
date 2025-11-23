var findOccurrences = function(arr, target) {
    const occurrences = [];
    for (let i = 0; i < arr.length; i++) {
        if (arr[i] === target) {
            occurrences.push(i);
        }
    }
    return occurrences;
};