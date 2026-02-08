var sortItems = function(n, m, group, beforeItems) {
    let groupId = m;
    for (let i = 0; i < n; i++) {
        if (group[i] === -1) {
            group[i] = groupId;
            groupId++;
        }
    }

    const itemGraph = {};
    const itemInDegree = new Array(n).fill(0);
    for (let i = 0; i < n; i++) {
        itemGraph[i] = [];
    }

    const groupGraph = {};
    const groupInDegree = new Array(groupId).fill(0);
    for (let i = 0; i < groupId; i++) {
        groupGraph[i] = [];
    }

    for (let i = 0; i < n; i++) {
        for (const prev of beforeItems[i]) {
            itemGraph[prev].push(i);
            itemInDegree[i]++;
            if (group[i] !== group[prev]) {
                groupGraph[group[prev]].push(group[i]);
                groupInDegree[group[i]]++;
            }
        }
    }

    const topologicalSort = (graph, inDegree, size) => {
        const order = [];
        const queue = [];
        for (let i = 0; i < size; i++) {
            if (inDegree[i] === 0) {
                queue.push(i);
            }
        }

        while (queue.length > 0) {
            const node = queue.shift();
            order.push(node);
            for (const neighbor of graph[node]) {
                inDegree[neighbor]--;
                if (inDegree[neighbor] === 0) {
                    queue.push(neighbor);
                }
            }
        }

        return order.length === size ? order : [];
    };

    const groupOrder = topologicalSort(groupGraph, groupInDegree, groupId);
    if (groupOrder.length === 0) {
        return [];
    }

    const itemOrder = topologicalSort(itemGraph, itemInDegree, n);
    if (itemOrder.length === 0) {
        return [];
    }

    const groupToItems = new Map();
    for (const item of itemOrder) {
        if (!groupToItems.has(group[item])) {
            groupToItems.set(group[item], []);
        }
        groupToItems.get(group[item]).push(item);
    }

    const result = [];
    for (const groupId of groupOrder) {
        if (groupToItems.has(groupId)) {
            result.push(...groupToItems.get(groupId));
        }
    }

    return result;
};