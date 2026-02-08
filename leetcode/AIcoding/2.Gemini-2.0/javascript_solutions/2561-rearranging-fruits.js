var minCost = function(fruits, baskets) {
    const n = fruits.length;
    const m = baskets.length;
    const allFruits = new Set(fruits.concat(...baskets));
    const fruitMap = new Map();
    let idx = 0;
    for (const fruit of allFruits) {
        fruitMap.set(fruit, idx++);
    }

    const adj = Array(idx).fill(null).map(() => []);
    const capacity = Array(idx).fill(0).map(() => Array(idx).fill(0));
    let source = idx;
    let sink = idx + 1;
    idx += 2;

    for (let i = 0; i < n; i++) {
        adj[source].push(fruitMap.get(fruits[i]));
        adj[fruitMap.get(fruits[i])].push(source);
        capacity[source][fruitMap.get(fruits[i])] = 1;
    }

    for (let i = 0; i < m; i++) {
        for (const fruit of baskets[i]) {
            adj[fruitMap.get(fruit)].push(sink);
            adj[sink].push(fruitMap.get(fruit));
            capacity[fruitMap.get(fruit)][sink] = 1;
        }
    }

    let totalCost = 0;
    for (const fruit of allFruits) {
        let fruitIndex = fruitMap.get(fruit);
        for (const otherFruit of allFruits) {
            if (fruit === otherFruit) continue;
            let otherFruitIndex = fruitMap.get(otherFruit);
            adj[fruitIndex].push(otherFruitIndex);
            adj[otherFruitIndex].push(fruitIndex);
            capacity[fruitIndex][otherFruitIndex] = Math.floor(100000 / 2);
            totalCost += Math.min(fruit, otherFruit);
        }
    }

    let maxFlow = 0;
    while (true) {
        const parent = Array(idx).fill(-1);
        const queue = [source];
        parent[source] = source;

        while (queue.length > 0) {
            const u = queue.shift();
            for (const v of adj[u]) {
                if (parent[v] === -1 && capacity[u][v] > 0) {
                    parent[v] = u;
                    queue.push(v);
                    if (v === sink) break;
                }
            }
            if (parent[sink] !== -1) break;
        }

        if (parent[sink] === -1) break;

        let pathFlow = Infinity;
        let s = sink;
        while (s !== source) {
            const p = parent[s];
            pathFlow = Math.min(pathFlow, capacity[p][s]);
            s = p;
        }

        maxFlow += pathFlow;
        s = sink;
        while (s !== source) {
            const p = parent[s];
            capacity[p][s] -= pathFlow;
            capacity[s][p] += pathFlow;
            s = p;
        }
    }

    return totalCost - maxFlow * 2;
};