var findChampion = function(competitions, results) {
    const scores = new Map();

    for (let i = 0; i < competitions.length; i++) {
        const [winner, loser] = results[i] === 1 ? competitions[i] : competitions[i].reverse();
        scores.set(winner, (scores.get(winner) || 0) + 3);
        scores.set(loser, (scores.get(loser) || 0));
    }

    let champion = '';
    let maxScore = 0;

    for (const [player, score] of scores.entries()) {
        if (score > maxScore) {
            maxScore = score;
            champion = player;
        }
    }

    return champion;
};