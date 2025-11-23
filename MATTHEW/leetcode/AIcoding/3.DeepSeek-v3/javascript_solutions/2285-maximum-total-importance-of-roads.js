var maximumImportance = function(n, roads) {
    const degree = new Array(n).fill(0);
    for (const [a, b] of roads) {
        degree[a]++;
        degree[b]++;
    }
    degree.sort((a, b) => a - b);
    let total = 0;
    for (let i = 0; i < n; i++) {
        total += degree[i] * (i + 1);
    }
    return total;
};