function minCostToMoveChips(chips) {
    let oddCount = 0, evenCount = 0;
    for (let chip of chips) {
        if (chip % 2 === 0) {
            evenCount++;
        } else {
            oddCount++;
        }
    }
    return Math.min(oddCount, evenCount);
}