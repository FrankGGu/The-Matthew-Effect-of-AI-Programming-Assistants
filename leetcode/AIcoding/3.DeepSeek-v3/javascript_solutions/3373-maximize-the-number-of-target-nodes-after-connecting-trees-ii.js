var maximizeNodes = function(n, edges, target) {
    const graph = Array.from({ length: n + 1 }, () => []);
    for (const [u, v] of edges) {
        graph[u].push(v);
        graph[v].push(u);
    }

    const parent = new Array(n + 1).fill(0);
    const children = Array.from({ length: n + 1 }, () => []);
    const depth = new Array(n + 1).fill(0);
    const queue = [1];
    parent[1] = 0;

    while (queue.length > 0) {
        const u = queue.shift();
        for (const v of graph[u]) {
            if (v !== parent[u]) {
                parent[v] = u;
                children[u].push(v);
                depth[v] = depth[u] + 1;
                queue.push(v);
            }
        }
    }

    const size = new Array(n + 1).fill(1);
    const postOrder = [];
    const stack = [[1, false]];
    while (stack.length > 0) {
        const [u, visited] = stack.pop();
        if (visited) {
            postOrder.push(u);
            for (const v of children[u]) {
                size[u] += size[v];
            }
        } else {
            stack.push([u, true]);
            for (let i = children[u].length - 1; i >= 0; i--) {
                stack.push([children[u][i], false]);
            }
        }
    }

    const isTarget = new Array(n + 1).fill(false);
    for (const node of target) {
        isTarget[node] = true;
    }

    const count = new Array(n + 1).fill(0);
    for (const u of postOrder) {
        count[u] = isTarget[u] ? 1 : 0;
        for (const v of children[u]) {
            count[u] += count[v];
        }
    }

    let max = 0;
    let bestU = 0;
    for (let u = 1; u <= n; u++) {
        if (count[u] > max) {
            max = count[u];
            bestU = u;
        }
    }

    const visited = new Array(n + 1).fill(false);
    const queue2 = [bestU];
    visited[bestU] = true;
    let total = 0;

    while (queue2.length > 0) {
        const u = queue2.shift();
        if (isTarget[u]) {
            total++;
        }
        for (const v of graph[u]) {
            if (!visited[v] && v !== parent[u]) {
                visited[v] = true;
                queue2.push(v);
            }
        }
    }

    const visited2 = new Array(n + 1).fill(false);
    const queue3 = [parent[bestU]];
    visited2[parent[bestU]] = true;
    let total2 = 0;

    while (queue3.length > 0) {
        const u = queue3.shift();
        if (isTarget[u]) {
            total2++;
        }
        for (const v of graph[u]) {
            if (!visited2[v] && v !== parent[u] && !visited[v]) {
                visited2[v] = true;
                queue3.push(v);
            }
        }
    }

    return total + total2;
};