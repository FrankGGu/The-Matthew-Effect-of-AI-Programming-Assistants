var mergeTriplets = function(triplets, target) {
    let max = [0, 0, 0];
    for (let triplet of triplets) {
        if (triplet[0] <= target[0] && triplet[1] <= target[1] && triplet[2] <= target[2]) {
            max[0] = Math.max(max[0], triplet[0]);
            max[1] = Math.max(max[1], triplet[1]);
            max[2] = Math.max(max[2], triplet[2]);
        }
    }
    return max[0] === target[0] && max[1] === target[1] && max[2] === target[2];
};