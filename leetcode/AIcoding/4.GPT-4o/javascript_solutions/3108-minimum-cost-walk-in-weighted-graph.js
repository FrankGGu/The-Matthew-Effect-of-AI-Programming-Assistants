class MinCostWalk {
    constructor() {
        this.graph = new Map();
    }

    addEdge(u, v, cost) {
        if (!this.graph.has(u)) this.graph.set(u, []);
        this.graph.get(u).push({ node: v, cost: cost });
    }

    minCost(start, end, maxCost) {
        const pq = [];
        pq.push([0, start]); // [cost, node]
        const costs = new Map();
        costs.set(start, 0);

        while (pq.length) {
            const [currentCost, node] = pq.shift();

            if (node === end) return currentCost;

            if (currentCost > maxCost) continue;

            if (!this.graph.has(node)) continue;

            for (const { node: neighbor, cost } of this.graph.get(node)) {
                const newCost = currentCost + cost;

                if (newCost <= maxCost) {
                    if (!costs.has(neighbor) || newCost < costs.get(neighbor)) {
                        costs.set(neighbor, newCost);
                        pq.push([newCost, neighbor]);
                    }
                }
            }
            pq.sort((a, b) => a[0] - b[0]); // Min-heap
        }

        return -1;
    }
}

var minCostWalk = new MinCostWalk();
minCostWalk.addEdge(0, 1, 10);
minCostWalk.addEdge(0, 2, 5);
minCostWalk.addEdge(1, 2, 2);
minCostWalk.addEdge(2, 1, 3);
minCostWalk.addEdge(1, 3, 1);
minCostWalk.addEdge(2, 3, 9);
);