var longestCycle = function(n, edges) {
    let adj = Array(n).fill(null).map(() => []);
    for (let i = 0; i < n; i++) {
        if (edges[i] !== -1) {
            adj[i].push(edges[i]);
        }
    }

    let visited = Array(n).fill(false);
    let path = Array(n).fill(0);
    let maxCycle = -1;

    for (let i = 0; i < n; i++) {
        if (!visited[i]) {
            let currentPathLength = 1;
            let stack = [[i, currentPathLength]];
            let currentPath = new Set();

            while(stack.length > 0){
                let [node, length] = stack.pop();

                if(visited[node]){
                    continue;
                }

                visited[node] = true;
                currentPath.add(node);
                path[node] = length;

                for(let neighbor of adj[node]){
                    if(!visited[neighbor]){
                        stack.push([neighbor, length + 1]);
                    } else if(currentPath.has(neighbor)){
                        maxCycle = Math.max(maxCycle, length - path[neighbor] + 1);
                    }
                }
            }
        }
    }

    return maxCycle;
};