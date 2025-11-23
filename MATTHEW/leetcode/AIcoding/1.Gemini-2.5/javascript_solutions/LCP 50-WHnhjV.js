var gemChange = function(gems, operations) {
    for (let i = 0; i < operations.length; i++) {
        const from = operations[i][0];
        const to = operations[i][1];

        const movedGems = Math.floor(gems[from] / 2);
        gems[from] -= movedGems;
        gems[to] += movedGems;
    }

    let minGems = Infinity;
    let maxGems = -Infinity;

    for (let i = 0; i < gems.length; i++) {
        if (gems[i] < minGems) {
            minGems = gems[i];
        }
        if (gems[i] > maxGems) {
            maxGems = gems[i];
        }
    }

    return maxGems - minGems;
};