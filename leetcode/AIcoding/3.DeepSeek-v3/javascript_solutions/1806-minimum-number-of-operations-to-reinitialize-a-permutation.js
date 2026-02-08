var reinitializePermutation = function(n) {
    let perm = new Array(n);
    for (let i = 0; i < n; i++) {
        perm[i] = i;
    }
    let original = [...perm];
    let arr = new Array(n);
    let operations = 0;
    do {
        for (let i = 0; i < n; i++) {
            if (i % 2 === 0) {
                arr[i] = perm[i / 2];
            } else {
                arr[i] = perm[n / 2 + (i - 1) / 2];
            }
        }
        operations++;
        perm = [...arr];
    } while (!arraysEqual(perm, original));
    return operations;
};

function arraysEqual(a, b) {
    for (let i = 0; i < a.length; i++) {
        if (a[i] !== b[i]) return false;
    }
    return true;
}