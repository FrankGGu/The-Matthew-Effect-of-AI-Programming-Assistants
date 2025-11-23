var findWinners = function(matches) {
    const lossCount = new Map();

    for (const [winner, loser] of matches) {
        lossCount.set(winner, (lossCount.get(winner) || 0));
        lossCount.set(loser, (lossCount.get(loser) || 0) + 1);
    }

    const zeroLosses = [];
    const oneLoss = [];

    for (const [player, losses] of lossCount.entries()) {
        if (losses === 0) {
            zeroLosses.push(player);
        } else if (losses === 1) {
            oneLoss.push(player);
        }
    }

    return [zeroLosses.sort((a, b) => a - b), oneLoss.sort((a, b) => a - b)];
};