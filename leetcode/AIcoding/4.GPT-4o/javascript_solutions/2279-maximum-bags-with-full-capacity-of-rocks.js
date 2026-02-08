function maxBags(capacity, rocks, additionalRocks) {
    let n = capacity.length;
    let bags = new Array(n);
    for (let i = 0; i < n; i++) {
        bags[i] = capacity[i] - rocks[i];
    }
    bags.sort((a, b) => a - b);

    let count = 0;
    for (let i = 0; i < n; i++) {
        if (additionalRocks >= bags[i]) {
            additionalRocks -= bags[i];
            count++;
        } else {
            break;
        }
    }
    return count;
}