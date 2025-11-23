function canFormTarget(triplets, target) {
    let hasA = false, hasB = false, hasC = false;

    for (const [a, b, c] of triplets) {
        if (a === target[0]) hasA = true;
        if (b === target[1]) hasB = true;
        if (c === target[2]) hasC = true;
    }

    return hasA && hasB && hasC;
}