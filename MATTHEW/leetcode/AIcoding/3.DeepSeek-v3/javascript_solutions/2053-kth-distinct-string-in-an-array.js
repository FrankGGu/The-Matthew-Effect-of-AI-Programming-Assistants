var kthDistinct = function(arr, k) {
    const frequency = {};
    for (const str of arr) {
        frequency[str] = (frequency[str] || 0) + 1;
    }
    const distinctStrings = [];
    for (const str of arr) {
        if (frequency[str] === 1) {
            distinctStrings.push(str);
        }
    }
    return distinctStrings.length >= k ? distinctStrings[k - 1] : "";
};