var sortItems = function(n, m, group, beforeItems) {
    for (let i = 0; i < n; i++) {
        if (group[i] === -1) {
            group[i] = m++;
        }
    }

    const itemGraph = new Array(n).fill(null).map(() => []);
    const itemIndegree = new Array(n).fill(0);
    const groupGraph = new Array(m).fill(null).map(() => []);
    const groupIndegree = new Array(m).fill(0);

    for (let i = 0; i < n; i++) {
        for (const beforeItem of beforeItems[i]) {
            itemGraph[beforeItem].push(i);
            itemIndegree[i]++;

            if (group[beforeItem] !== group[i]) {
                if (!groupGraph[group[beforeItem]].includes(group[i])) {
                    groupGraph[group[beforeItem]].push(group[i]);
                    groupIndegree[group[i]]++;
                }
            }
        }
    }

    function topologicalSort(graph, indegree, nodes) {
        const queue = [];
        for (const node of nodes) {
            if (indegree[node] === 0) {
                queue.push(node);
            }
        }

        const result = [];
        while (queue.length > 0) {
            const node = queue.shift();
            result.push(node);
            for (const neighbor of graph[node]) {
                indegree[neighbor]--;
                if (indegree[neighbor] === 0) {
                    queue.push(neighbor);
                }
            }
        }

        return result.length === nodes.length ? result : null;
    }

    const sortedGroups = topologicalSort(groupGraph, groupIndegree, Array.from({ length: m }, (_, i) => i));
    if (!sortedGroups) {
        return [];
    }

    const itemGroups = new Array(m).fill(null).map(() => []);
    for (let i = 0; i < n; i++) {
        itemGroups[group[i]].push(i);
    }

    const sortedItems = [];
    for (const groupId of sortedGroups) {
        const itemsInGroup = itemGroups[groupId];
        const sortedItemsInGroup = topologicalSort(itemGraph, itemIndegree, itemsInGroup);
        if (!sortedItemsInGroup) {
            return [];
        }
        sortedItems.push(...sortedItemsInGroup);
    }

    return sortedItems;
};