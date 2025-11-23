var numFriendRequests = function(ages) {
    const count = new Array(121).fill(0);
    for (const age of ages) {
        count[age]++;
    }

    let res = 0;
    for (let a = 1; a <= 120; a++) {
        for (let b = 1; b <= 120; b++) {
            if (b <= 0.5 * a + 7 || b > a || (b > 100 && a < 100)) {
                continue;
            }
            res += count[a] * count[b];
            if (a === b) {
                res -= count[a];
            }
        }
    }
    return res;
};