var matrixRankTransform = function(matrix) {
    const m = matrix.length;
    const n = matrix[0].length;
    const ranks = Array(m).fill(null).map(() => Array(n).fill(1));
    const adj = {};
    const rowMax = Array(m).fill(0);
    const colMax = Array(n).fill(0);

    for (let i = 0; i < m; i++) {
        for (let j = 0; j < n; j++) {
            if (!adj[matrix[i][j]]) {
                adj[matrix[i][j]] = [];
            }
        }
    }

    const sortedValues = Object.keys(adj).sort((a, b) => a - b);

    for (const value of sortedValues) {
        const graph = {};
        const nodeToIndex = {};
        let nodeCount = 0;

        for (let i = 0; i < m; i++) {
            for (let j = 0; j < n; j++) {
                if (matrix[i][j] == value) {
                    const rowNode = `r${i}`;
                    const colNode = `c${j}`;

                    if (!graph[rowNode]) {
                        graph[rowNode] = [];
                        nodeToIndex[rowNode] = nodeCount++;
                    }
                    if (!graph[colNode]) {
                        graph[colNode] = [];
                        nodeToIndex[colNode] = nodeCount++;
                    }

                    graph[rowNode].push(colNode);
                    graph[colNode].push(rowNode);
                }
            }
        }

        const visited = {};
        const components = [];

        function dfs(node, component) {
            visited[node] = true;
            component.push(node);
            for (const neighbor of graph[node] || []) {
                if (!visited[neighbor]) {
                    dfs(neighbor, component);
                }
            }
        }

        for (const node in graph) {
            if (!visited[node]) {
                const component = [];
                dfs(node, component);
                components.push(component);
            }
        }

        for (const component of components) {
            let maxRank = 0;
            for (const node of component) {
                const type = node[0];
                const index = parseInt(node.substring(1));
                if (type === 'r') {
                    maxRank = Math.max(maxRank, rowMax[index]);
                } else {
                    maxRank = Math.max(maxRank, colMax[index]);
                }
            }

            for (const node of component) {
                const type = node[0];
                const index = parseInt(node.substring(1));
                ranks[type === 'r' ? index : Math.floor(index)][type === 'r' ? Math.floor(index) : index] = maxRank + 1;
                if (type === 'r') {
                    rowMax[index] = maxRank + 1;
                } else {
                    colMax[index] = maxRank + 1;
                }
            }
        }
    }

    return ranks;
};