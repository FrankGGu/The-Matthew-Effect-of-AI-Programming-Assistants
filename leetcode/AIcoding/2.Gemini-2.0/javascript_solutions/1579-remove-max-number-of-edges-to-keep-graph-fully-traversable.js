var maxNumEdgesToRemove = function(n, edges) {
    let parentA = Array(n + 1).fill(0).map((_, i) => i);
    let parentB = Array(n + 1).fill(0).map((_, i) => i);

    function find(parent, i) {
        if (parent[i] === i) {
            return i;
        }
        return parent[i] = find(parent, parent[i]);
    }

    function union(parent, i, j) {
        let rootI = find(parent, i);
        let rootJ = find(parent, j);
        if (rootI !== rootJ) {
            parent[rootI] = rootJ;
            return true;
        }
        return false;
    }

    let removedEdges = 0;
    let edgesA = 0;
    let edgesB = 0;

    for (let edge of edges) {
        if (edge[0] === 3) {
            if (union(parentA, edge[1], edge[2])) {
                union(parentB, edge[1], edge[2]);
                edgesA++;
                edgesB++;
            } else {
                removedEdges++;
            }
        }
    }

    for (let edge of edges) {
        if (edge[0] === 1) {
            if (union(parentA, edge[1], edge[2])) {
                edgesA++;
            } else {
                removedEdges++;
            }
        } else if (edge[0] === 2) {
            if (union(parentB, edge[1], edge[2])) {
                edgesB++;
            } else {
                removedEdges++;
            }
        }
    }

    if (edgesA !== n - 1 || edgesB !== n - 1) {
        return -1;
    }

    return removedEdges;
};