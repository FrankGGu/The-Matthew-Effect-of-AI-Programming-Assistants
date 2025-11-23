var maxKDivisibleComponents = function(n, edges, values) {
    let adj = Array(n).fill(null).map(() => []);
    for (let [u, v] of edges) {
        adj[u].push(v);
        adj[v].push(u);
    }

    let visited = Array(n).fill(false);
    let maxComponents = 0;

    function dfs(node, parent) {
        visited[node] = true;
        let sum = values[node];

        for (let neighbor of adj[node]) {
            if (neighbor !== parent && !visited[neighbor]) {
                sum += dfs(neighbor, node);
            }
        }

        return sum;
    }

    for (let i = 0; i < n; i++) {
        if (!visited[i]) {
            dfs(i, -1);
            maxComponents++;
        }
    }

    return maxComponents;
};

var maxKDivisibleComponents = function(n, edges, values, k) {
    let adj = Array(n).fill(null).map(() => []);
    for (let [u, v] of edges) {
        adj[u].push(v);
        adj[v].push(u);
    }

    let visited = Array(n).fill(false);
    let components = 0;

    function dfs(node) {
        visited[node] = true;
        let sum = values[node];

        for (let neighbor of adj[node]) {
            if (!visited[neighbor]) {
                sum += dfs(neighbor);
            }
        }

        if (sum % k === 0) {
            components++;
        }

        return sum;
    }

    for (let i = 0; i < n; i++) {
        if (!visited[i]) {
            dfs(i);
        }
    }

    return components;
};

var maxKDivisibleComponents = function(n, edges, values, k) {
    const adj = Array(n).fill(null).map(() => []);
    for (const [u, v] of edges) {
        adj[u].push(v);
        adj[v].push(u);
    }

    let count = 0;
    const visited = new Array(n).fill(false);

    function dfs(node) {
        visited[node] = true;
        let sum = values[node];

        for (const neighbor of adj[node]) {
            if (!visited[neighbor]) {
                sum += dfs(neighbor);
            }
        }

        if (sum % k === 0) {
            count++;
        }

        return sum;
    }

    for (let i = 0; i < n; i++) {
        if (!visited[i]) {
            dfs(i);
        }
    }

    return count;
};

var maxKDivisibleComponents = function(n, edges, values, k) {
    const adj = Array(n).fill(null).map(() => []);
    for (const [u, v] of edges) {
        adj[u].push(v);
        adj[v].push(u);
    }

    let count = 0;
    const visited = new Array(n).fill(false);

    function dfs(node) {
        visited[node] = true;
        let sum = values[node];

        for (const neighbor of adj[node]) {
            if (!visited[neighbor]) {
                sum += dfs(neighbor);
            }
        }

        if (sum % k === 0) {
            count++;
        }

        return sum;
    }

    for (let i = 0; i < n; i++) {
        if (!visited[i]) {
            dfs(i);
        }
    }

    return count;
};