var reinitializePermutation = function(n) {
    let perm = Array.from({length: n}, (_, i) => i);
    let original = [...perm];
    let count = 0;

    do {
        let newPerm = new Array(n);
        for (let i = 0; i < n; i++) {
            if (i % 2 === 0) {
                newPerm[i] = perm[i / 2];
            } else {
                newPerm[i] = perm[n / 2 + Math.floor(i / 2)];
            }
        }
        perm = newPerm;
        count++;
    } while (!perm.every((val, index) => val === original[index]));

    return count;
};