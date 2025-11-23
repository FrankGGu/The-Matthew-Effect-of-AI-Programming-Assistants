var earliestAndLatest = function(n, firstPlayer, secondPlayer) {
    let earliest = Infinity;
    let latest = -Infinity;

    const dfs = (players, round) => {
        if (players.length === 1) return;

        const nextPlayers = [];
        const m = players.length;
        const half = Math.floor((m + 1) / 2);

        for (let i = 0; i < half; i++) {
            const a = players[i];
            const b = players[m - 1 - i];

            if (a === firstPlayer && b === secondPlayer) {
                earliest = Math.min(earliest, round);
                latest = Math.max(latest, round);
                return;
            }

            if (a === firstPlayer || a === secondPlayer) {
                nextPlayers.push(a);
            } else if (b === firstPlayer || b === secondPlayer) {
                nextPlayers.push(b);
            } else {
                nextPlayers.push(a);
            }
        }

        dfs(nextPlayers, round + 1);
    };

    const initialPlayers = Array.from({length: n}, (_, i) => i + 1);
    dfs(initialPlayers, 1);

    return [earliest, latest];
};