var findWinners = function(matches) {
    const losses = new Map();
    for (const [winner, loser] of matches) {
        losses.set(winner, losses.get(winner) || 0);
        losses.set(loser, (losses.get(loser) || 0) + 1);
    }

    const zeroLoss = [];
    const oneLoss = [];

    for (const [player, lossCount] of losses) {
        if (lossCount === 0) {
            zeroLoss.push(player);
        } else if (lossCount === 1) {
            oneLoss.push(player);
        }
    }

    zeroLoss.sort((a, b) => a - b);
    oneLoss.sort((a, b) => a - b);

    return [zeroLoss, oneLoss];
};