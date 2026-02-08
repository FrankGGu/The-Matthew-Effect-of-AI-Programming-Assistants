var findWinners = function(matches) {
    const lossCounts = new Map();

    for (const [winner, loser] of matches) {
        if (!lossCounts.has(winner)) {
            lossCounts.set(winner, 0);
        }
        lossCounts.set(loser, (lossCounts.get(loser) || 0) + 1);
    }

    const zeroLoss = [];
    const oneLoss = [];

    for (const [player, losses] of lossCounts.entries()) {
        if (losses === 0) {
            zeroLoss.push(player);
        } else if (losses === 1) {
            oneLoss.push(player);
        }
    }

    zeroLoss.sort((a, b) => a - b);
    oneLoss.sort((a, b) => a - b);

    return [zeroLoss, oneLoss];
};