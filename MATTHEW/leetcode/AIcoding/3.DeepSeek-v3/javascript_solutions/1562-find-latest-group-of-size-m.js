var findLatestStep = function(arr, m) {
    const n = arr.length;
    if (m === n) return n;

    const parent = Array(n + 2).fill(0).map((_, i) => i);
    const size = Array(n + 2).fill(0);
    const count = Array(n + 2).fill(0);
    let res = -1;

    function find(u) {
        if (parent[u] !== u) {
            parent[u] = find(parent[u]);
        }
        return parent[u];
    }

    function union(u, v) {
        const rootU = find(u);
        const rootV = find(v);
        if (rootU === rootV) return;

        parent[rootV] = rootU;
        count[size[rootU]]--;
        count[size[rootV]]--;
        size[rootU] += size[rootV];
        count[size[rootU]]++;
    }

    for (let i = 0; i < n; i++) {
        const pos = arr[i];
        size[pos] = 1;
        count[1]++;

        if (size[pos - 1] > 0) {
            union(pos - 1, pos);
        }
        if (size[pos + 1] > 0) {
            union(pos, pos + 1);
        }

        if (count[m] > 0) {
            res = i + 1;
        }
    }

    return res;
};