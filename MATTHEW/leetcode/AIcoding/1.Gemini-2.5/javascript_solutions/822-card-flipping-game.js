var flipgame = function(fronts, backs) {
    const n = fronts.length;
    const badNumbers = new Set();

    for (let i = 0; i < n; i++) {
        if (fronts[i] === backs[i]) {
            badNumbers.add(fronts[i]);
        }
    }

    let minGoodNumber = Infinity;

    for (let i = 0; i < n; i++) {
        if (!badNumbers.has(fronts[i])) {
            minGoodNumber = Math.min(minGoodNumber, fronts[i]);
        }
        if (!badNumbers.has(backs[i])) {
            minGoodNumber = Math.min(minGoodNumber, backs[i]);
        }
    }

    return minGoodNumber;
};