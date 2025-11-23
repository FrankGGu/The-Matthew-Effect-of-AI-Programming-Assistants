function findPlayersWithZeroOrOneLosses(matches) {
    const losses = new Map();

    for (const [player1, player2] of matches) {
        if (!losses.has(player1)) {
            losses.set(player1, 0);
        }
        if (!losses.has(player2)) {
            losses.set(player2, 0);
        }

        if (player1 === player2) continue;

        losses.set(player2, losses.get(player2) + 1);
    }

    const zeroLosses = [];
    const oneLoss = [];

    for (const [player, count] of losses) {
        if (count === 0) {
            zeroLosses.push(player);
        } else if (count === 1) {
            oneLoss.push(player);
        }
    }

    return [zeroLosses.sort(), oneLoss.sort()];
}