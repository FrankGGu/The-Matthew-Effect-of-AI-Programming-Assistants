var giveGem = function(gems, operations) {
    for (const [i, j] of operations) {
        const give = Math.floor(gems[i] / 2);
        gems[i] -= give;
        gems[j] += give;
    }

    let min = gems[0];
    let max = gems[0];
    for (let i = 1; i < gems.length; i++) {
        min = Math.min(min, gems[i]);
        max = Math.max(max, gems[i]);
    }

    return max - min;
};