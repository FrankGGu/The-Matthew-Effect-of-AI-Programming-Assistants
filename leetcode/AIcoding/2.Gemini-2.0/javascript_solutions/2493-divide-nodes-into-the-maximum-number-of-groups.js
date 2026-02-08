var maximumGroups = function(n, preferences) {
    let adj = Array(n).fill(null).map(() => []);
    for (let i = 0; i < preferences.length; i++) {
        for (let j = i + 1; j < preferences.length; j++) {
            let common = preferences[i].filter(x => preferences[j].includes(x));
            if (common.length > 0) {
                adj[i].push(j);
                adj[j].push(i);
            }
        }
    }

    let visited = Array(n).fill(false);
    let components = 0;

    function dfs(node) {
        visited[node] = true;
        for (let neighbor of adj[node]) {
            if (!visited[neighbor]) {
                dfs(neighbor);
            }
        }
    }

    for (let i = 0; i < n; i++) {
        if (!visited[i]) {
            dfs(i);
            components++;
        }
    }

    let l = 0, r = n;
    while (l < r) {
        let mid = Math.floor((l + r + 1) / 2);
        if (mid * (mid + 1) / 2 <= n) {
            l = mid;
        } else {
            r = mid - 1;
        }
    }

    return l - components + 1;
};