var minReorder = function(n, connections) {
    const graph = new Map();
    let count = 0;

    for (const [a, b] of connections) {
        if (!graph.has(a)) graph.set(a, []);
        if (!graph.has(b)) graph.set(b, []);
        graph.get(a).push([b, 1]);
        graph.get(b).push([a, 0]);
    }

    const visited = new Set();
    const dfs = (city) => {
        visited.add(city);
        for (const [nextCity, needChange] of graph.get(city)) {
            if (!visited.has(nextCity)) {
                count += needChange;
                dfs(nextCity);
            }
        }
    };

    dfs(0);
    return count;
};