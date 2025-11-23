function maximumSumOfEdgeValues(edges, values, k) {
    const n = values.length;
    const graph = Array.from({ length: n }, () => []);

    for (const [u, v] of edges) {
        graph[u].push(v);
        graph[v].push(u);
    }

    const visited = new Array(n).fill(false);
    const maxHeap = [];

    function dfs(node) {
        visited[node] = true;
        const heap = [];
        for (const neighbor of graph[node]) {
            if (!visited[neighbor]) {
                const childMax = dfs(neighbor);
                heap.push(childMax);
            }
        }

        heap.sort((a, b) => b - a);
        let sum = values[node];
        for (let i = 0; i < Math.min(k, heap.length); i++) {
            sum += heap[i];
        }

        if (heap.length >= k) {
            maxHeap.push(sum);
        }

        return sum;
    }

    dfs(0);

    maxHeap.sort((a, b) => b - a);
    let result = 0;
    for (let i = 0; i < Math.min(k, maxHeap.length); i++) {
        result += maxHeap[i];
    }

    return result;
}