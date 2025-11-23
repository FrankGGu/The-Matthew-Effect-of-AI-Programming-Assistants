var circularGameLosers = function(n, k) {
    const visited = new Array(n + 1).fill(false);
    let current = 1;
    let step = 1;
    while (!visited[current]) {
        visited[current] = true;
        current = (current + step * k) % n;
        if (current === 0) current = n;
        step++;
    }
    const losers = [];
    for (let i = 1; i <= n; i++) {
        if (!visited[i]) {
            losers.push(i);
        }
    }
    return losers;
};