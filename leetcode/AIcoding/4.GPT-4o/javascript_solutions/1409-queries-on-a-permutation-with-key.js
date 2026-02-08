var findPermutation = function(n, key) {
    let permutation = Array.from({ length: n }, (_, i) => i + 1);
    for (let i = 0; i < n; i++) {
        let idx = permutation.indexOf(key[i]);
        if (idx !== i) {
            [permutation[i], permutation[idx]] = [permutation[idx], permutation[i]];
        }
    }
    return permutation;
};