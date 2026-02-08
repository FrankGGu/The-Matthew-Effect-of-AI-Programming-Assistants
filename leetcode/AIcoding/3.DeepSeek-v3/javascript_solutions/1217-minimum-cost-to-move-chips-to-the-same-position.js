var minCostToMoveChips = function(position) {
    let even = 0, odd = 0;
    for (let pos of position) {
        if (pos % 2 === 0) {
            even++;
        } else {
            odd++;
        }
    }
    return Math.min(even, odd);
};