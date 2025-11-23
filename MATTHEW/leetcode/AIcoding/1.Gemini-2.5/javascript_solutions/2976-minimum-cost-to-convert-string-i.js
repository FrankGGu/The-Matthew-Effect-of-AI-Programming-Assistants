var minimumCost = function(source, target, original, changed, cost) {
    const ALPHABET_SIZE = 26;
    const dist = Array(ALPHABET_SIZE).fill(0).map(() => Array(ALPHABET_SIZE).fill(Infinity));

    for (let i = 0; i < ALPHABET_SIZE; i++) {
        dist[i][i] = 0;
    }

    for (let i = 0; i < original.length; i++) {
        const u = original[i].charCodeAt(0) - 'a'.charCodeAt(0);
        const v = changed[i].charCodeAt(0) - 'a'.charCodeAt(0);
        dist[u][v] = Math.min(dist[u][v], cost[i]);
    }

    for (let k = 0; k < ALPHABET_SIZE; k++) {
        for (let i = 0; i < ALPHABET_SIZE; i++) {
            for (let j = 0; j < ALPHABET_SIZE; j++) {
                if (dist[i][k] !== Infinity && dist[k][j] !== Infinity) {
                    dist[i][j] = Math.min(dist[i][j], dist[i][k] + dist[k][j]);
                }
            }
        }
    }

    let totalCost = 0;
    for (let i = 0; i < source.length; i++) {
        const srcCharIdx = source.charCodeAt(i) - 'a'.charCodeAt(0);
        const tgtCharIdx = target.charCodeAt(i) - 'a'.charCodeAt(0);

        if (srcCharIdx === tgtCharIdx) {
            continue;
        }

        if (dist[srcCharIdx][tgtCharIdx] === Infinity) {
            return -1;
        }
        totalCost += dist[srcCharIdx][tgtCharIdx];
    }

    return totalCost;
};