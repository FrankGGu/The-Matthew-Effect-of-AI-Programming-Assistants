var leastOpsExpressTarget = function(x, target) {
    let pos = 0, neg = 0, k = 0;
    while (target > 0) {
        let curr = target % x;
        target = Math.floor(target / x);
        if (k > 0) {
            let newPos = Math.min(curr * k + pos, (curr + 1) * k + neg);
            let newNeg = Math.min((x - curr) * k + pos, (x - curr - 1) * k + neg);
            pos = newPos;
            neg = newNeg;
        } else {
            pos = curr * 2;
            neg = (x - curr) * 2;
        }
        k++;
    }
    return Math.min(pos, k + neg) - 1;
};