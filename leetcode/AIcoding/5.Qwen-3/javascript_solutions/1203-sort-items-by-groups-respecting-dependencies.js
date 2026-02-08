function sortItems(n, m, group, beforeItems) {
    const graph = {};
    const inDegree = {};
    const groupGraph = {};
    const groupInDegree = {};

    for (let i = 0; i < n; i++) {
        if (!graph[i]) graph[i] = [];
        if (!inDegree[i]) inDegree[i] = 0;
    }

    for (let i = 0; i < m; i++) {
        if (!groupGraph[i]) groupGraph[i] = [];
        if (!groupInDegree[i]) groupInDegree[i] = 0;
    }

    const groupMap = {};
    for (let i = 0; i < n; i++) {
        const g = group[i];
        if (!groupMap[g]) groupMap[g] = [];
        groupMap[g].push(i);
    }

    for (let i = 0; i < n; i++) {
        for (const prev of beforeItems[i]) {
            if (!graph[prev].includes(i)) {
                graph[prev].push(i);
                inDegree[i]++;
            }
        }
    }

    for (let g = 0; g < m; g++) {
        for (let i = 0; i < n; i++) {
            if (group[i] === g) {
                for (const prev of beforeItems[i]) {
                    if (group[prev] !== g && !groupGraph[group[prev]].includes(g)) {
                        groupGraph[group[prev]].push(g);
                        groupInDegree[g]++;
                    }
                }
            }
        }
    }

    const topologicalSort = (nodes, graph, inDegree) => {
        const queue = [];
        for (const node of nodes) {
            if (inDegree[node] === 0) {
                queue.push(node);
            }
        }

        const result = [];
        while (queue.length > 0) {
            const node = queue.shift();
            result.push(node);
            for (const neighbor of graph[node]) {
                inDegree[neighbor]--;
                if (inDegree[neighbor] === 0) {
                    queue.push(neighbor);
                }
            }
        }

        return result.length === nodes.length ? result : [];
    };

    const groupOrder = topologicalSort(Object.keys(groupInDegree).map(Number), groupGraph, groupInDegree);
    if (groupOrder.length === 0) return [];

    const result = [];
    for (const g of groupOrder) {
        const items = groupMap[g];
        if (items) {
            const itemOrder = topologicalSort(items, graph, { ...inDegree });
            if (itemOrder.length !== items.length) return [];
            result.push(...itemOrder);
        }
    }

    return result;
}