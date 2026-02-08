var pushDominoes = function(dominoes) {
    const n = dominoes.length;
    const forces = new Array(n).fill(0);
    let force = 0;

    for (let i = 0; i < n; i++) {
        if (dominoes[i] === 'R') {
            force = n;
        } else if (dominoes[i] === 'L') {
            force = 0;
        } else {
            force = Math.max(0, force - 1);
        }
        forces[i] += force;
    }

    force = 0;
    for (let i = n - 1; i >= 0; i--) {
        if (dominoes[i] === 'L') {
            force = n;
        } else if (dominoes[i] === 'R') {
            force = 0;
        } else {
            force = Math.max(0, force - 1);
        }
        forces[i] -= force;
    }

    let result = "";
    for (let i = 0; i < n; i++) {
        if (forces[i] > 0) {
            result += 'R';
        } else if (forces[i] < 0) {
            result += 'L';
        } else {
            result += '.';
        }
    }

    return result;
};