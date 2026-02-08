var countConnectedComponents = function(n, edges) {
    const parent = Array(n + 1).fill(0).map((_, i) => i);

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

    for (let i = 1; i <= n; i++) {
        for (let j = i + 1; j <= n; j++) {
            if (lcm(i, j) <= n) {
                union(i, j);
            }
        }
    }

    function gcd(a, b) {
        if (b === 0) {
            return a;
        }
        return gcd(b, a % b);
    }

    function lcm(a, b) {
        return (a * b) / gcd(a, b);
    }

    let count = 0;
    const roots = new Set();
    for (let i = 1; i <= n; i++) {
        const root = find(i);
        if (!roots.has(root)) {
            roots.add(root);
            count++;
        }
    }

    return count;
};