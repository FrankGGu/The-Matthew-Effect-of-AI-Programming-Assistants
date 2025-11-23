var modifyGraphEdgeWeights = function(n, edges, source, destination, target) {
    const adj = Array(n).fill(null).map(() => []);
    const zeroEdges = [];

    for (let i = 0; i < edges.length; i++) {
        const [u, v, w] = edges[i];
        if (w === -1) {
            zeroEdges.push(i);
        }
        adj[u].push([v, w, i]);
        adj[v].push([u, w, i]);
    }

    function dijkstra(start, end, graph) {
        const dist = Array(n).fill(Infinity);
        dist[start] = 0;
        const pq = [[0, start]];

        while (pq.length > 0) {
            pq.sort((a, b) => a[0] - b[0]);
            const [d, u] = pq.shift();

            if (d > dist[u]) {
                continue;
            }

            for (const [v, w] of graph[u]) {
                if (dist[v] > dist[u] + w) {
                    dist[v] = dist[u] + w;
                    pq.push([dist[v], v]);
                }
            }
        }
        return dist[end];
    }

    let low = 0;
    let high = 2000 * edges.length + 1;
    let possible = false;

    while (low <= high) {
        const mid = Math.floor((low + high) / 2);
        const tempEdges = edges.map(edge => [...edge]);

        for (let i = 0; i < zeroEdges.length; i++) {
            tempEdges[zeroEdges[i]][2] = mid;
        }

        const tempAdj = Array(n).fill(null).map(() => []);
        for (let i = 0; i < tempEdges.length; i++) {
            const [u, v, w] = tempEdges[i];
            tempAdj[u].push([v, w]);
            tempAdj[v].push([u, w]);
        }

        const distance = dijkstra(source, destination, tempAdj);

        if (distance === target) {
            possible = true;
            break;
        } else if (distance < target) {
            low = mid + 1;
        } else {
            high = mid - 1;
        }
    }

    if (!possible) {
        const tempEdges = edges.map(edge => [...edge]);

        for (let i = 0; i < zeroEdges.length; i++) {
            tempEdges[zeroEdges[i]][2] = 1;
        }

        const tempAdj = Array(n).fill(null).map(() => []);
        for (let i = 0; i < tempEdges.length; i++) {
            const [u, v, w] = tempEdges[i];
            tempAdj[u].push([v, w]);
            tempAdj[v].push([u, w]);
        }
        const distance = dijkstra(source, destination, tempAdj);
          if(distance < target) return [];

         low = 1;
         high = 2000 * edges.length + 1;
         while(low <= high) {
            const mid = Math.floor((low + high) / 2);
            const tempEdges = edges.map(edge => [...edge]);

            for (let i = 0; i < zeroEdges.length; i++) {
                tempEdges[zeroEdges[i]][2] = mid;
            }
            const tempAdj = Array(n).fill(null).map(() => []);
            for (let i = 0; i < tempEdges.length; i++) {
                const [u, v, w] = tempEdges[i];
                tempAdj[u].push([v, w]);
                tempAdj[v].push([u, w]);
            }
            const distance = dijkstra(source, destination, tempAdj);
            if(distance == target) break;
             else if(distance > target) high = mid - 1;
             else low = mid + 1;

         }
           if(dijkstra(source, destination, tempAdj) != target) return [];
    }

    let remaining = target;
    let assigned = 0;

    const result = edges.map(edge => [...edge]);
    const assignedWeights = Array(zeroEdges.length).fill(0);

    for (let i = 0; i < zeroEdges.length; i++) {
        const index = zeroEdges[i];
        result[index][2] = 1;
        assignedWeights[i] = 1;
    }

    const tempAdj = Array(n).fill(null).map(() => []);
        for (let i = 0; i < result.length; i++) {
            const [u, v, w] = result[i];
            tempAdj[u].push([v, w]);
            tempAdj[v].push([u, w]);
        }
    let currentShortestPath = dijkstra(source, destination, tempAdj);

    if (currentShortestPath < target) {
        let diff = target - currentShortestPath;

        for (let i = 0; i < zeroEdges.length; i++) {
            const index = zeroEdges[i];
            let add = Math.min(2000-1, diff);
            result[index][2] += add;
            diff -= add;
            if (diff == 0) break;
        }
    }

    const finalAdj = Array(n).fill(null).map(() => []);
    for (let i = 0; i < result.length; i++) {
        const [u, v, w] = result[i];
        finalAdj[u].push([v, w]);
        finalAdj[v].push([u, w]);
    }
    currentShortestPath = dijkstra(source, destination, finalAdj);

        if (currentShortestPath !== target) return [];

    return result;
};