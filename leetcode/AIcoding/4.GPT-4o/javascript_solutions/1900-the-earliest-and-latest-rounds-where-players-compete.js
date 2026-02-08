function earliestAndLatest(n, firstPlayer, secondPlayer) {
    const results = [];

    function dfs(round, players) {
        if (players.length === 1) {
            if (players[0] === firstPlayer && players[1] === secondPlayer) {
                results.push(round);
            }
            return;
        }

        const nextRound = [];
        for (let i = 0; i < players.length; i += 2) {
            if (i + 1 < players.length) {
                nextRound.push(Math.min(players[i], players[i + 1]));
            } else {
                nextRound.push(players[i]);
            }
        }

        dfs(round + 1, nextRound);
    }

    const players = Array.from({ length: n }, (_, i) => i + 1);
    dfs(1, players);

    return [Math.min(...results), Math.max(...results)];
}