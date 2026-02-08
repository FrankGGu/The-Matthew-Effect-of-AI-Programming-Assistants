var findChampion = function(n, matches) {
    const lostTeams = new Set();

    for (const match of matches) {
        const loser = match[1];
        lostTeams.add(loser);
    }

    let champion = -1;
    let potentialChampionsCount = 0;

    for (let i = 0; i < n; i++) {
        if (!lostTeams.has(i)) {
            potentialChampionsCount++;
            champion = i;
        }
    }

    if (potentialChampionsCount === 1) {
        return champion;
    } else {
        return -1;
    }
};