var maximumBags = function(capacity, rocks, additionalRocks) {
    const n = capacity.length;
    const neededRocks = new Array(n);

    for (let i = 0; i < n; i++) {
        neededRocks[i] = capacity[i] - rocks[i];
    }

    neededRocks.sort((a, b) => a - b);

    let fullBags = 0;
    for (let i = 0; i < n; i++) {
        if (neededRocks[i] === 0) {
            fullBags++;
        } else if (additionalRocks >= neededRocks[i]) {
            additionalRocks -= neededRocks[i];
            fullBags++;
        } else {
            break;
        }
    }

    return fullBags;
};