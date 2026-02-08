function findWinners(matches) {
    const playerWins = new Map();
    const playerLosses = new Map();

    for (const [winner, loser] of matches) {
        playerWins.set(winner, (playerWins.get(winner) || 0) + 1);
        playerLosses.set(loser, (playerLosses.get(loser) || 0) + 1);
    }

    const result = [[], []];

    for (const player of playerWins.keys()) {
        if (!playerLosses.has(player)) {
            result[0].push(player);
        }
    }

    for (const [player, losses] of playerLosses.entries()) {
        if (losses === 1) {
            result[1].push(player);
        }
    }

    result[0].sort((a, b) => a - b);
    result[1].sort((a, b) => a - b);

    return result;
}