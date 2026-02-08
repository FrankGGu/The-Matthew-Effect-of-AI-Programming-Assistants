var minCost = function(n, m, costs) {
    costs.sort((a, b) => a[2] - b[2]);
    let parent = Array(n + 1).fill(0).map((_, i) => i);

    function find(i) {
        if (parent[i] === i) {
            return i;
        }
        return parent[i] = find(parent[i]);
    }

    function union(i, j) {
        let rootI = find(i);
        let rootJ = find(j);
        if (rootI !== rootJ) {
            parent[rootI] = rootJ;
            return true;
        }
        return false;
    }

    let min_cost = 0;
    let edges = 0;

    for (let i = 0; i < costs.length; i++) {
        let [u, v, cost] = costs[i];
        if (union(u, v)) {
            min_cost += cost;
            edges++;
        }
    }

    if (edges !== n - 1) {
        return -1;
    }

    return min_cost;
};