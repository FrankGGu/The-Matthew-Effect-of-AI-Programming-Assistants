var maximumEvenSplit = function(finalSum) {
    if (finalSum % 2 !== 0) {
        return [];
    }

    const result = [];
    let currentEven = 2;

    while (finalSum >= currentEven) {
        result.push(currentEven);
        finalSum -= currentEven;
        currentEven += 2;
    }

    // If there's a remaining sum, add it to the last element
    // This ensures we maintain the maximum number of elements and distinctness
    // as the last element will be the largest and adding to it will keep it distinct
    // from all previous (smaller) elements.
    if (finalSum > 0) {
        // If result is empty, it means finalSum was 0 initially, or too small to add 2.
        // But we already handled finalSum % 2 !== 0.
        // If finalSum was 0, loop wouldn't run, result would be [].
        // If finalSum was 2, result would be [2], finalSum becomes 0.
        // So finalSum > 0 implies result is not empty.
        result[result.length - 1] += finalSum;
    }

    return result;
};