var mergeTriplets = function(triplets, target) {
    let foundX = 0;
    let foundY = 0;
    let foundZ = 0;

    const tx = target[0];
    const ty = target[1];
    const tz = target[2];

    for (const triplet of triplets) {
        const a = triplet[0];
        const b = triplet[1];
        const c = triplet[2];

        if (a <= tx && b <= ty && c <= tz) {
            foundX = Math.max(foundX, a);
            foundY = Math.max(foundY, b);
            foundZ = Math.max(foundZ, c);
        }
    }

    return foundX === tx && foundY === ty && foundZ === tz;
};