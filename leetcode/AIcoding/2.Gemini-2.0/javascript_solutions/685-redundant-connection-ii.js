var findRedundantDirectedConnection = function(edges) {
    let n = edges.length;
    let parents = new Array(n + 1).fill(0);
    let inDegree = new Array(n + 1).fill(0);

    for (let i = 0; i < n; i++) {
        inDegree[edges[i][1]]++;
    }

    let twoParents = [];
    for (let i = 0; i < n; i++) {
        if (inDegree[edges[i][1]] > 1) {
            twoParents.push(edges[i]);
        }
    }

    if (twoParents.length > 0) {
        let edge1 = twoParents[twoParents.length - 1];
        edges.splice(edges.indexOf(edge1), 1);
        if (isCyclic(edges, n)) {
            return edge1;
        } else {
            return twoParents[0];
        }
    } else {
        return findCycle(edges, n);
    }

    function findCycle(edges, n) {
        let parents = new Array(n + 1).fill(0);
        for (let i = 1; i <= n; i++) {
            parents[i] = i;
        }

        let cycle = null;
        for (let edge of edges) {
            let u = edge[0];
            let v = edge[1];
            let rootU = find(parents, u);
            let rootV = find(parents, v);
            if (rootU === rootV) {
                cycle = edge;
            } else {
                parents[rootV] = rootU;
            }
        }
        return cycle;
    }

    function find(parents, i) {
        if (parents[i] === i) {
            return i;
        }
        return parents[i] = find(parents, parents[i]);
    }

    function isCyclic(edges, n) {
        let parents = new Array(n + 1).fill(0);
        for (let i = 1; i <= n; i++) {
            parents[i] = i;
        }

        for (let edge of edges) {
            let u = edge[0];
            let v = edge[1];
            let rootU = find(parents, u);
            let rootV = find(parents, v);
            if (rootU === rootV) {
                return true;
            } else {
                parents[rootV] = rootU;
            }
        }
        return false;
    }
};