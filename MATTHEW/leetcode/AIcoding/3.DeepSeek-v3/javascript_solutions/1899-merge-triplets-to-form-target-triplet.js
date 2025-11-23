var mergeTriplets = function(triplets, target) {
    let [x, y, z] = target;
    let possible = [false, false, false];

    for (let [a, b, c] of triplets) {
        if (a <= x && b <= y && c <= z) {
            if (a === x) possible[0] = true;
            if (b === y) possible[1] = true;
            if (c === z) possible[2] = true;
        }
    }

    return possible[0] && possible[1] && possible[2];
};