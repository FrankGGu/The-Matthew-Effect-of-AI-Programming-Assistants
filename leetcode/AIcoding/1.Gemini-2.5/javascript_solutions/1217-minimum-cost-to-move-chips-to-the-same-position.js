var minCostToMoveChips = function(chips) {
    let evenCount = 0;
    let oddCount = 0;

    for (let i = 0; i < chips.length; i++) {
        if (chips[i] % 2 === 0) {
            evenCount++;
        } else {
            oddCount++;
        }
    }

    return Math.min(evenCount, oddCount);
};