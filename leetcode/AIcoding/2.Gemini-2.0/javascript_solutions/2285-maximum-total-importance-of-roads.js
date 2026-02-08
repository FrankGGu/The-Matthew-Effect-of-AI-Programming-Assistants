var maximumImportance = function(n, roads) {
    const degrees = new Array(n).fill(0);
    for (const road of roads) {
        degrees[road[0]]++;
        degrees[road[1]]++;
    }

    const sortedDegrees = degrees.map((degree, index) => ({ degree, index })).sort((a, b) => b.degree - a.degree);

    const importance = new Array(n);
    let value = n;
    for (const { index } of sortedDegrees) {
        importance[index] = value;
        value--;
    }

    let totalImportance = 0;
    for (const road of roads) {
        totalImportance += importance[road[0]] + importance[road[1]];
    }

    return totalImportance;
};