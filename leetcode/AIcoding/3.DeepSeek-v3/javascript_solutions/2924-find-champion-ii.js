var findChampion = function(n, edges) {
    const inDegree = new Array(n).fill(0);

    for (const [u, v] of edges) {
        inDegree[v]++;
    }

    let champion = -1;
    for (let i = 0; i < n; i++) {
        if (inDegree[i] === 0) {
            if (champion !== -1) {
                return -1;
            }
            champion = i;
        }
    }

    return champion;
};