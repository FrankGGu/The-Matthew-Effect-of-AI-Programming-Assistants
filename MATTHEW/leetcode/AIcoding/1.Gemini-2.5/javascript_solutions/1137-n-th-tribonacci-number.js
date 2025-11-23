var tribonacci = function(n) {
    if (n === 0) {
        return 0;
    }
    if (n === 1 || n === 2) {
        return 1;
    }

    let t0 = 0;
    let t1 = 1;
    let t2 = 1;

    for (let i = 3; i <= n; i++) {
        let nextT = t0 + t1 + t2;
        t0 = t1;
        t1 = t2;
        t2 = nextT;
    }

    return t2;
};