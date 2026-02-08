var sortItems = function(n, m, group, beforeItems) {
    const groupMap = new Map();
    for (let i = 0; i < m; i++) groupMap.set(i, []);
    for (let i = 0; i < n; i++) {
        if (group[i] === -1) {
            group[i] = m++;
        }
        groupMap.get(group[i]).push(i);
    }

    const buildGraph = (n, edges) => {
        const graph = Array.from({ length: n }, () => []);
        const indegree = new Array(n).fill(0);
        for (const [u, v] of edges) {
            graph[u].push(v);
            indegree[v]++;
        }
        return [graph, indegree];
    };

    const topologicalSort = (n, graph, indegree) => {
        const result = [];
        const queue = [];
        for (let i = 0; i < n; i++) {
            if (indegree[i] === 0) queue.push(i);
        }
        while (queue.length) {
            const node = queue.shift();
            result.push(node);
            for (const neighbor of graph[node]) {
                indegree[neighbor]--;
                if (indegree[neighbor] === 0) queue.push(neighbor);
            }
        }
        return result.length === n ? result : [];
    };

    const itemGraph = buildGraph(n, beforeItems);
    const itemOrder = topologicalSort(n, itemGraph[0], itemGraph[1]);
    if (itemOrder.length === 0) return [];

    const groupGraph = buildGraph(m, []);
    for (let i = 0; i < n; i++) {
        for (const before of beforeItems[i]) {
            if (group[i] !== group[before]) {
                groupGraph[0][group[before]].push(group[i]);
                groupGraph[1][group[i]]++;
            }
        }
    }

    const groupOrder = topologicalSort(m, groupGraph[0], groupGraph[1]);
    if (groupOrder.length === 0) return [];

    const result = [];
    const groupToItems = new Map();
    for (const g of groupOrder) {
        groupToItems.set(g, groupMap.get(g));
    }

    for (const g of groupOrder) {
        const items = groupToItems.get(g);
        for (const item of items) {
            result.push(itemOrder[item]);
        }
    }

    return result;
};