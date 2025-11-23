var maxCount = function(m, n, ops) {
    let minA = m;
    let minB = n;

    for (let op of ops) {
        minA = Math.min(minA, op[0]);
        minB = Math.min(minB, op[1]);
    }

    return minA * minB;
};