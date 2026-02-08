var maxBuilding = function(n, restrictions) {
    restrictions.sort((a, b) => a[0] - b[0]);
    let m = restrictions.length;
    if (m === 0) return n - 1;

    restrictions.unshift([1, 0]);
    m++;

    for (let i = 1; i < m; i++) {
        restrictions[i][1] = Math.min(restrictions[i][1], restrictions[i-1][1] + (restrictions[i][0] - restrictions[i-1][0]));
    }

    for (let i = m - 2; i >= 0; i--) {
        restrictions[i][1] = Math.min(restrictions[i][1], restrictions[i+1][1] + (restrictions[i+1][0] - restrictions[i][0]));
    }

    let maxHeight = 0;
    for (let i = 0; i < m - 1; i++) {
        let left = restrictions[i][0], right = restrictions[i+1][0];
        let h1 = restrictions[i][1], h2 = restrictions[i+1][1];
        let diff = Math.abs(h1 - h2);
        let distance = right - left - diff;
        maxHeight = Math.max(maxHeight, Math.max(h1, h2) + Math.floor(distance / 2));
    }

    maxHeight = Math.max(maxHeight, restrictions[m-1][1] + (n - restrictions[m-1][0]));

    return maxHeight;
};