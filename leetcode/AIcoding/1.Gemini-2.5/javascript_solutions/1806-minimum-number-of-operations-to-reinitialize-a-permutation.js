var reinitializePermutation = function(n) {
    let perm = new Array(n);
    let initialPerm = new Array(n);

    for (let i = 0; i < n; i++) {
        perm[i] = i;
        initialPerm[i] = i;
    }

    let operations = 0;

    while (true) {
        operations++;
        let newPerm = new Array(n);

        for (let i = 0; i < n; i++) {
            if (i % 2 === 0) {
                newPerm[i] = perm[i / 2];
            } else {
                newPerm[i] = perm[n / 2 + (i - 1) / 2];
            }
        }
        perm = newPerm;

        let isInitial = true;
        for (let i = 0; i < n; i++) {
            if (perm[i] !== initialPerm[i]) {
                isInitial = false;
                break;
            }
        }

        if (isInitial) {
            break;
        }
    }

    return operations;
};