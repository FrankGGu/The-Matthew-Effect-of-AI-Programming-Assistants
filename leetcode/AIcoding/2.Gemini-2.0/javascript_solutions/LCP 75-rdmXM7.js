var getMaximumHealth = function(position, health, directions) {
    const n = position.length;
    const players = [];
    for (let i = 0; i < n; i++) {
        players.push({ pos: position[i], health: health[i], dir: directions[i] });
    }

    players.sort((a, b) => a.pos - b.pos);

    let alive = new Array(n).fill(true);
    let maxHealth = 0;

    for (let i = 0; i < n; i++) {
        if (!alive[i]) continue;

        let currentHealth = players[i].health;
        let currentPos = players[i].pos;
        let currentDir = players[i].dir;

        for (let j = 0; j < n; j++) {
            if (i === j || !alive[j]) continue;

            let otherHealth = players[j].health;
            let otherPos = players[j].pos;
            let otherDir = players[j].dir;

            if (currentDir === 'R' && otherDir === 'L' && currentPos < otherPos) {
                if (currentHealth > otherHealth) {
                    currentHealth -= otherHealth;
                    alive[j] = false;
                } else if (currentHealth < otherHealth) {
                    otherHealth -= currentHealth;
                    alive[i] = false;
                    currentHealth = 0;
                    break;
                } else {
                    alive[i] = false;
                    alive[j] = false;
                    currentHealth = 0;
                    break;
                }
            }
        }
        if (alive[i]) {
            maxHealth += currentHealth;
        }
    }

    return maxHealth;
};