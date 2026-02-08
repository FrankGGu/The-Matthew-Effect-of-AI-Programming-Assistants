var findWinningPlayers = function(players) {
    let winningPlayersCount = 0;
    const n = players.length;

    for (let i = 0; i < n; i++) {
        let isWinner = true;
        const p1 = players[i];

        for (let j = 0; j < n; j++) {
            if (i === j) {
                continue;
            }

            const p2 = players[j];

            // Check if p2 dominates p1
            // p2 dominates p1 if:
            // p2's attack is greater than or equal to p1's attack
            // AND p2's defense is greater than or equal to p1's defense
            // AND (p2's attack is strictly greater than p1's attack OR p2's defense is strictly greater than p1's defense)
            if (p2[0] >= p1[0] && p2[1] >= p1[1] && (p2[0] > p1[0] || p2[1] > p1[1])) {
                isWinner = false;
                break;
            }
        }

        if (isWinner) {
            winningPlayersCount++;
        }
    }

    return winningPlayersCount;
};