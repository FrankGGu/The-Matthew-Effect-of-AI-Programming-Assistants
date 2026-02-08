var shortestSequence = function(rolls, k) {
    let count = 1;
    let set = new Set();
    for (let roll of rolls) {
        set.add(roll);
        if (set.size === k) {
            count++;
            set = new Set();
        }
    }
    return count;
};