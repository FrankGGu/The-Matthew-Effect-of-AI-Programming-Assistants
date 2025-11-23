var mostVisited = function(n, rounds) {
    const start = rounds[0];
    const end = rounds[rounds.length - 1];

    const result = [];
    if (start <= end) {
        for (let i = start; i <= end; i++) {
            result.push(i);
        }
    } else {
        for (let i = 1; i <= end; i++) {
            result.push(i);
        }
        for (let i = start; i <= n; i++) {
            result.push(i);
        }
    }

    return result;
};