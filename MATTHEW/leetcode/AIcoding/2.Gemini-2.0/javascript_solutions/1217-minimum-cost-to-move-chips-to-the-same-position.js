var minCostToMoveChips = function(position) {
    let evenCount = 0;
    let oddCount = 0;

    for (let p of position) {
        if (p % 2 === 0) {
            evenCount++;
        } else {
            oddCount++;
        }
    }

    return Math.min(evenCount, oddCount);
};