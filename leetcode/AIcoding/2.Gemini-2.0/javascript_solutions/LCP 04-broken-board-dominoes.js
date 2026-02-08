var domino = function(m, n, broken) {
    let brokenSet = new Set();
    for (let i = 0; i < broken.length; i += 2) {
        brokenSet.add(broken[i] + ',' + broken[i + 1]);
    }

    if ((m * n - broken.length / 2 * 2) % 2 !== 0) {
        return 0;
    }

    let graph = {};
    let count = 0;

    for (let i = 0; i < m; i++) {
        for (let j = 0; j < n; j++) {
            if (!brokenSet.has(i + ',' + j)) {
                count++;

                graph[i + ',' + j] = [];

                if (i > 0 && !brokenSet.has((i - 1) + ',' + j)) {
                    graph[i + ',' + j].push((i - 1) + ',' + j);
                }
                if (i < m - 1 && !brokenSet.has((i + 1) + ',' + j)) {
                    graph[i + ',' + j].push((i + 1) + ',' + j);
                }
                if (j > 0 && !brokenSet.has(i + ',' + (j - 1))) {
                    graph[i + ',' + j].push(i + ',' + (j - 1));
                }
                if (j < n - 1 && !brokenSet.has(i + ',' + (j + 1))) {
                    graph[i + ',' + j].push(i + ',' + (j + 1));
                }
            }
        }
    }

    let match = {};
    let visited = {};

    function dfs(node) {
        if (visited[node]) {
            return false;
        }
        visited[node] = true;

        for (let neighbor of graph[node]) {
            if (!match[neighbor] || dfs(match[neighbor])) {
                match[neighbor] = node;
                return true;
            }
        }
        return false;
    }

    let matching = 0;
    for (let i = 0; i < m; i++) {
        for (let j = 0; j < n; j++) {
            if (!brokenSet.has(i + ',' + j)) {
                visited = {};
                if (dfs(i + ',' + j)) {
                    matching++;
                }
            }
        }
    }

    return matching;
};