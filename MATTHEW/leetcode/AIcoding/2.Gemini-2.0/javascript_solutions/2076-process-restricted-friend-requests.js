var friendRequests = function(n, requests, restrictions) {
    const parent = Array(n).fill(0).map((_, i) => i);

    function find(x) {
        if (parent[x] !== x) {
            parent[x] = find(parent[x]);
        }
        return parent[x];
    }

    function union(x, y) {
        const rootX = find(x);
        const rootY = find(y);
        if (rootX !== rootY) {
            parent[rootX] = rootY;
        }
    }

    function areConnected(x, y) {
        return find(x) === find(y);
    }

    const ans = [];
    for (const [u, v] of requests) {
        let valid = true;
        for (const [a, b] of restrictions) {
            if ((areConnected(u, a) && areConnected(v, b)) || (areConnected(u, b) && areConnected(v, a))) {
                valid = false;
                break;
            }
        }

        if (valid) {
            union(u, v);
        }

        ans.push(valid);
    }

    return ans;
};