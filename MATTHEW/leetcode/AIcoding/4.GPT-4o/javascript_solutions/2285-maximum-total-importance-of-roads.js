function maximumImportance(n, roads) {
    const degree = new Array(n).fill(0);

    for (const [u, v] of roads) {
        degree[u]++;
        degree[v]++;
    }

    degree.sort((a, b) => b - a);

    let importance = 0;

    for (let i = 0; i < n; i++) {
        importance += degree[i] * (i + 1);
    }

    return importance;
}