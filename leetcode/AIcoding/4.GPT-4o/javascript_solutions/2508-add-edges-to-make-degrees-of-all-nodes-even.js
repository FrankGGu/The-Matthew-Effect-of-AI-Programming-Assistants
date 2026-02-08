function makeAllDegreesEven(n, edges) {
    const degree = new Array(n).fill(0);

    for (const [u, v] of edges) {
        degree[u]++;
        degree[v]++;
    }

    const oddNodes = degree.reduce((acc, deg, idx) => {
        if (deg % 2 !== 0) acc.push(idx);
        return acc;
    }, []);

    const result = [];

    for (let i = 0; i < oddNodes.length; i += 2) {
        result.push([oddNodes[i], oddNodes[i + 1]]);
    }

    return result;
}