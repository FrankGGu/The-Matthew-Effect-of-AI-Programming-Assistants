var guardCastle = function(guards) {
    let total = 0;
    let n = guards.length;

    for (let i = 0; i < n; i++) {
        total += Math.max(guards[i][0], guards[i][1]);
    }

    return total;
};