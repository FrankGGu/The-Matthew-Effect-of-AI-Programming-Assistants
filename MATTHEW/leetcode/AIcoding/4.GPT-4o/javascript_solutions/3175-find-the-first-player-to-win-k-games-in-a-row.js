function firstPlayerToWinKGames(players, k) {
    const winCount = new Map();
    const lastWinIndex = new Map();

    for (let i = 0; i < players.length; i++) {
        const player = players[i];
        if (!winCount.has(player)) {
            winCount.set(player, 0);
        }
        winCount.set(player, winCount.get(player) + 1);
        lastWinIndex.set(player, i);

        if (winCount.get(player) === k) {
            return player;
        }
    }

    return "";
}