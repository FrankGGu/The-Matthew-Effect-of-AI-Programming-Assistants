var maximumBags = function(capacity, rocks, additionalRocks) {
    const diff = [];
    for (let i = 0; i < capacity.length; i++) {
        diff.push(capacity[i] - rocks[i]);
    }
    diff.sort((a, b) => a - b);
    let count = 0;
    for (let i = 0; i < diff.length; i++) {
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