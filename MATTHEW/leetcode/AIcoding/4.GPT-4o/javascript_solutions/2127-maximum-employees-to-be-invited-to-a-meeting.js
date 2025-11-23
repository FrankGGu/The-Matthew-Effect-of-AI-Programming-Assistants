var maxEmployees = function(A) {
    let n = A.length;
    let graph = new Array(n).fill(0).map(() => []);
    for (let i = 0; i < n; i++) {
        for (let j = 0; j < n; j++) {
            if (A[i][j] === 1) {
                graph[i].push(j);
            }
        }
    }

    let maxCount = 0;

    const dfs = (node, visited) => {
        visited[node] = true;
        let count = 1;
        for (let neighbor of graph[node]) {
            if (!visited[neighbor]) {
                count += dfs(neighbor, visited);
            }
        }
        return count;
    };

    for (let i = 0; i < n; i++) {
        let visited = new Array(n).fill(false);
        maxCount = Math.max(maxCount, dfs(i, visited));
    }

    return maxCount;
};