var findWinners = function(matches) {
    const losses = {};
    for (const match of matches) {
        const winner = match[0];
        const loser = match[1];

        if (!(winner in losses)) {
            losses[winner] = 0;
        }

        if (!(loser in losses)) {
            losses[loser] = 0;
        }

        losses[loser]++;
    }

    const noLoss = [];
    const oneLoss = [];

    for (const player in losses) {
        if (losses[player] === 0) {
            noLoss.push(parseInt(player));
        } else if (losses[player] === 1) {
            oneLoss.push(parseInt(player));
        }
    }

    noLoss.sort((a, b) => a - b);
    oneLoss.sort((a, b) => a - b);

    return [noLoss, oneLoss];
};