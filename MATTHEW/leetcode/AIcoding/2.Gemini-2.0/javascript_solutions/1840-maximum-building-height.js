var maxBuilding = function(n, restrictions) {
    restrictions.sort((a, b) => a[0] - b[0]);
    restrictions.unshift([1, 0]);
    restrictions.push([n, n - 1]);

    for (let i = 1; i < restrictions.length; i++) {
        restrictions[i][1] = Math.min(restrictions[i][1], restrictions[i - 1][1] + restrictions[i][0] - restrictions[i - 1][0]);
    }

    for (let i = restrictions.length - 2; i >= 0; i--) {
        restrictions[i][1] = Math.min(restrictions[i][1], restrictions[i + 1][1] + restrictions[i + 1][0] - restrictions[i][0]);
    }

    let maxHeight = 0;
    for (let i = 1; i < restrictions.length; i++) {
        let a = restrictions[i - 1][0];
        let b = restrictions[i - 1][1];
        let c = restrictions[i][0];
        let d = restrictions[i][1];

        let dist = Math.abs(c - a);
        let heightDiff = Math.abs(d - b);

        if (heightDiff <= dist) {
            maxHeight = Math.max(maxHeight, Math.max(b, d) + (dist - heightDiff) / 2);
        } else {
            maxHeight = Math.max(maxHeight, Math.max(b, d));
        }
    }

    return Math.floor(maxHeight);
};