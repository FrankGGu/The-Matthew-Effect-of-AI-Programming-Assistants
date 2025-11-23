var flipgame = function(fronts, backs) {
    let same = new Set();
    for (let i = 0; i < fronts.length; i++) {
        if (fronts[i] === backs[i]) {
            same.add(fronts[i]);
        }
    }
    let min = Infinity;
    for (let num of fronts) {
        if (!same.has(num)) {
            min = Math.min(min, num);
        }
    }
    for (let num of backs) {
        if (!same.has(num)) {
            min = Math.min(min, num);
        }
    }
    return min === Infinity ? 0 : min;
};