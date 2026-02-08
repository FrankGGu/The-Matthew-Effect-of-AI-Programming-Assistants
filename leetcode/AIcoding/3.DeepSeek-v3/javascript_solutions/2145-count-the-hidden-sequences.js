var numberOfArrays = function(differences, lower, upper) {
    let min = 0, max = 0, current = 0;
    for (let diff of differences) {
        current += diff;
        min = Math.min(min, current);
        max = Math.max(max, current);
    }
    const total = (upper - lower) - (max - min) + 1;
    return total > 0 ? total : 0;
};