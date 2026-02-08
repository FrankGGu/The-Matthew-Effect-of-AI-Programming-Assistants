var maximumBags = function(capacity, rocks, additionalRocks) {
    const n = capacity.length;
    const diff = new Array(n);
    for (let i = 0; i < n; i++) {
        diff[i] = capacity[i] - rocks[i];
    }
    diff.sort((a, b) => a - b);
    let count = 0;
    for (let i = 0; i < n; i++) {
        if (diff[i] === 0) {
            count++;
        } else if (additionalRocks >= diff[i]) {
            additionalRocks -= diff[i];
            count++;
        } else {
            break;
        }
    }
    return count;
};