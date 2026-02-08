var pushDominoes = function(dominoes) {
    const n = dominoes.length;
    const forces = new Array(n).fill(0);

    for (let i = 0; i < n; i++) {
        if (dominoes[i] === 'R') forces[i] = Infinity;
        else if (dominoes[i] === 'L') forces[i] = -Infinity;
    }

    for (let i = 1; i < n; i++) {
        if (forces[i] !== 0) continue;
        forces[i] = forces[i - 1] === Infinity ? Infinity : (forces[i - 1] > 0 ? forces[i - 1] + 1 : 0);
    }

    for (let i = n - 2; i >= 0; i--) {
        if (forces[i] !== 0) continue;
        forces[i] = forces[i + 1] === -Infinity ? -Infinity : (forces[i + 1] < 0 ? forces[i + 1] - 1 : 0);
    }

    let result = '';
    for (let i = 0; i < n; i++) {
        if (forces[i] === Infinity) result += 'R';
        else if (forces[i] === -Infinity) result += 'L';
        else if (forces[i] > 0) result += 'R';
        else if (forces[i] < 0) result += 'L';
        else result += '.';
    }

    return result;
};