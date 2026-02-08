var reinitializePermutation = function(n) {
    let perm = Array.from({length: n}, (_, i) => i);
    let arr = Array.from({length: n});
    let ops = 0;
    let initial = [...perm];

    do {
        for (let i = 0; i < n; i++) {
            if (i % 2 === 0) {
                arr[i] = perm[i / 2];
            } else {
                arr[i] = perm[n / 2 + (i - 1) / 2];
            }
        }
        perm = [...arr];
        ops++;
    } while (!perm.every((val, index) => val === initial[index]));

    return ops;
};