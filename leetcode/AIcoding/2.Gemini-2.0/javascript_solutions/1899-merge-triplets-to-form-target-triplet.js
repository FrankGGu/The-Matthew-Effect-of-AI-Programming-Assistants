var mergeTriplets = function(triplets, target) {
    let good = [0, 0, 0];
    for (let triplet of triplets) {
        if (triplet[0] <= target[0] && triplet[1] <= target[1] && triplet[2] <= target[2]) {
            if (triplet[0] === target[0]) good[0] = 1;
            if (triplet[1] === target[1]) good[1] = 1;
            if (triplet[2] === target[2]) good[2] = 1;
        }
    }
    return good[0] + good[1] + good[2] === 3;
};