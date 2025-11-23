var flipgame = function(fronts, backs) {
    const badNumbers = new Set();
    for (let i = 0; i < fronts.length; i++) {
        if (fronts[i] === backs[i]) {
            badNumbers.add(fronts[i]);
        }
    }
    let min = Infinity;
    for (let num of fronts) {
        if (!badNumbers.has(num)) {
            min = Math.min(min, num);
        }
    }
    for (let num of backs) {
        if (!badNumbers.has(num)) {
            min = Math.min(min, num);
        }
    }
    return min === Infinity ? 0 : min;
};