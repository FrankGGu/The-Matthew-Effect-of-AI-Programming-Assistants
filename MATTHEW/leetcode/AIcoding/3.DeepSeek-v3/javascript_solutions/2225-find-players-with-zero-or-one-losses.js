var findWinners = function(matches) {
    const losses = new Map();
    const players = new Set();

    for (const [winner, loser] of matches) {
        players.add(winner);
        players.add(loser);
        losses.set(loser, (losses.get(loser) || 0) + 1);
    }

    const noLoss = [];
    const oneLoss = [];

    for (const player of players) {
        const count = losses.get(player) || 0;
        if (count === 0) {
            noLoss.push(player);
        } else if (count === 1) {
            oneLoss.push(player);
        }
    }

    noLoss.sort((a, b) => a - b);
    oneLoss.sort((a, b) => a - b);

    return [noLoss, oneLoss];
};