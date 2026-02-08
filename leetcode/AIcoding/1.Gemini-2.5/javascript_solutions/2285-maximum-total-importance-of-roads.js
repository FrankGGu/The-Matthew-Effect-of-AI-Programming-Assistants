var maximumImportance = function(n, roads) {
    const degrees = new Array(n).fill(0);

    for (const road of roads) {
        const city1 = road[0];
        const city2 = road[1];
        degrees[city1]++;
        degrees[city2]++;
    }

    degrees.sort((a, b) => a - b);

    let totalImportance = 0;
    for (let i = 0; i < n; i++) {
        totalImportance += degrees[i] * (i + 1);
    }

    return totalImportance;
};