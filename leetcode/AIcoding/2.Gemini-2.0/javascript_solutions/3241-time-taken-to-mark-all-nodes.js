var timeTaken = function(n, edges, time) {
    const adj = Array(n).fill(null).map(() => []);
    for (const [u, v] of edges) {
        adj[u].push(v);
        adj[v].push(u);
    }

    const result = Array(n).fill(0);
    const visited = Array(n).fill(false);
    const queue = [[0, 0]]; // [node, currentTime]
    visited[0] = true;

    while (queue.length > 0) {
        const [node, currentTime] = queue.shift();
        result[node] = currentTime;

        let nextNode = -1;
        let minTime = Infinity;

        for (const neighbor of adj[node]) {
            if (!visited[neighbor]) {
                if (time[node] < minTime) {
                    minTime = time[node];
                    nextNode = neighbor;
                } else if (time[node] === minTime && neighbor < nextNode){
                    nextNode = neighbor;
                }
            }
        }

        if (nextNode !== -1) {
          visited[nextNode] = true;
          queue.push([nextNode, currentTime + time[node] + 1]);
        } else {
          for (const neighbor of adj[node]) {
            if (!visited[neighbor]) {
                visited[neighbor] = true;
                queue.push([neighbor, currentTime + time[node] + 1]);
            }
          }
        }
    }

    return result;
};