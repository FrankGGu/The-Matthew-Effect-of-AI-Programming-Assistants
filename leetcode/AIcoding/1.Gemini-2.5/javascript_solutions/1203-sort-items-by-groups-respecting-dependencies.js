var sortItems = function(n, m, group, beforeItems) {
    // Step 1: Assign new group IDs to items that don't belong to any group (-1)
    let nextGroupId = m;
    const itemGroup = Array(n);
    for (let i = 0; i < n; i++) {
        if (group[i] === -1) {
            itemGroup[i] = nextGroupId++;
        } else {
            itemGroup[i] = group[i];
        }
    }
    const numGroups = nextGroupId;

    // Step 2: Build dependency graphs and in-degrees for items and groups
    const itemGraph = Array.from({ length: n }, () => []);
    const itemInDegree = Array(n).fill(0);

    const groupGraph = Array.from({ length: numGroups }, () => new Set()); // Use Set to avoid duplicate group edges
    const groupInDegree = Array(numGroups).fill(0);

    for (let i = 0; i < n; i++) {
        for (const prevItem of beforeItems[i]) {
            // Item dependencies
            itemGraph[prevItem].push(i);
            itemInDegree[i]++;

            // Group dependencies
            const prevGroup = itemGroup[prevItem];
            const currGroup = itemGroup[i];
            if (prevGroup !== currGroup) {
                if (!groupGraph[prevGroup].has(currGroup)) {
                    groupGraph[prevGroup].add(currGroup);
                    groupInDegree[currGroup]++;
                }
            }
        }
    }

    // Step 3: Perform topological sort for items and groups
    const topologicalSort = (numNodes, graph, inDegree) => {
        const queue = [];
        for (let i = 0; i < numNodes; i++) {
            if (inDegree[i] === 0) {
                queue.push(i);
            }
        }

        const result = [];
        let head = 0;
        while (head < queue.length) {
            const u = queue[head++];
            result.push(u);

            for (const v of graph[u]) {
                inDegree[v]--;
                if (inDegree[v] === 0) {
                    queue.push(v);
                }
            }
        }
        return result;
    };

    const sortedItems = topologicalSort(n, itemGraph, itemInDegree);
    const sortedGroups = topologicalSort(numGroups, groupGraph.map(s => Array.from(s)), groupInDegree); // Convert Set to Array for topologicalSort

    // If cycles exist in either graph, return an empty array
    if (sortedItems.length !== n || sortedGroups.length !== numGroups) {
        return [];
    }

    // Step 4: Reconstruct the final order
    // Group items by their assigned group ID, maintaining their sorted order
    const itemsInGroup = new Map();
    for (let i = 0; i < numGroups; i++) {
        itemsInGroup.set(i, []);
    }
    for (const item of sortedItems) {
        itemsInGroup.get(itemGroup[item]).push(item);
    }

    const finalResult = [];
    for (const groupId of sortedGroups) {
        finalResult.push(...itemsInGroup.get(groupId));
    }

    return finalResult;
};