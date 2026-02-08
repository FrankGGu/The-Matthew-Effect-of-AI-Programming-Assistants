var pushDominoes = function(dominoes) {
    const n = dominoes.length;
    const forces = new Array(n).fill(0);

    let currentForce = 0;
    for (let i = 0; i < n; i++) {
        if (dominoes[i] === 'R') {
            currentForce = n;
        } else if (dominoes[i] === 'L') {
            currentForce = 0;
        } else {
            currentForce = Math.max(0, currentForce - 1);
        }
        forces[i] += currentForce;
    }

    currentForce = 0;
    for (let i = n - 1; i >= 0; i--) {
        if (dominoes[i] === 'L') {
            currentForce = -n;
        } else if (dominoes[i] === 'R') {
            currentForce = 0;
        } else {
            currentForce = Math.min(0, currentForce + 1);
        }
        forces[i] += currentForce;
    }

    const result = [];
    for (let i = 0; i < n; i++) {
        if (forces[i] > 0) {
            result.push('R');
        } else if (forces[i] < 0) {
            result.push('L');
        } else {
            result.push('.');
        }
    }

    return result.join('');
};