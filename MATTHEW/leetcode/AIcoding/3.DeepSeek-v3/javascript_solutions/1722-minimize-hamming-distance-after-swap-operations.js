var minimumHammingDistance = function(source, target, allowedSwaps) {
    const n = source.length;
    const parent = Array(n).fill().map((_, i) => i);

    const find = (u) => {
        if (parent[u] !== u) {
            parent[u] = find(parent[u]);
        }
        return parent[u];
    };

    const union = (u, v) => {
        const rootU = find(u);
        const rootV = find(v);
        if (rootU !== rootV) {
            parent[rootV] = rootU;
        }
    };

    for (const [u, v] of allowedSwaps) {
        union(u, v);
    }

    const groups = new Map();
    for (let i = 0; i < n; i++) {
        const root = find(i);
        if (!groups.has(root)) {
            groups.set(root, []);
        }
        groups.get(root).push(i);
    }

    let distance = 0;
    for (const indices of groups.values()) {
        const freq = new Map();
        for (const i of indices) {
            const num = source[i];
            freq.set(num, (freq.get(num) || 0) + 1);
        }
        for (const i of indices) {
            const num = target[i];
            if (freq.has(num) && freq.get(num) > 0) {
                freq.set(num, freq.get(num) - 1);
            } else {
                distance++;
            }
        }
    }

    return distance;
};