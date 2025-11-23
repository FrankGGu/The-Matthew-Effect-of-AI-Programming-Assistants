function findLatestGroup(arr, m) {
    const n = arr.length;
    const parent = new Array(n + 1).fill(0).map((_, i) => i);
    const size = new Array(n + 1).fill(1);

    function find(x) {
        while (parent[x] !== x) {
            parent[x] = parent[parent[x]];
            x = parent[x];
        }
        return x;
    }

    function union(x, y) {
        const rootX = find(x);
        const rootY = find(y);
        if (rootX === rootY) return;
        if (size[rootX] < size[rootY]) {
            [rootX, rootY] = [rootY, rootX];
        }
        parent[rootY] = rootX;
        size[rootX] += size[rootY];
    }

    let result = -1;
    const count = new Array(n + 1).fill(0);

    for (let i = 0; i < n; i++) {
        const index = arr[i];
        count[index] = 1;
        if (index > 1 && count[index - 1] > 0) {
            union(index, index - 1);
        }
        if (index < n && count[index + 1] > 0) {
            union(index, index + 1);
        }
        const root = find(index);
        if (size[root] === m) {
            result = i + 1;
        }
    }

    return result;
}