var giveGem = function(gems, operations) {
    for (const [x, y] of operations) {
        const half = Math.floor(gems[x] / 2);
        gems[x] -= half;
        gems[y] += half;
    }
    const max = Math.max(...gems);
    const min = Math.min(...gems);
    return max - min;
};