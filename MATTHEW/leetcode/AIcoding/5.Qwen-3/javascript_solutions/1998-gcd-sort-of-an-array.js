function gcdSort(nums) {
    const maxNum = Math.max(...nums);
    const parent = new Array(maxNum + 1).fill(0).map((_, i) => i);

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
            parent[rootY] = rootX;
        }
    }

    for (let i = 2; i <= maxNum; i++) {
        for (let j = i * 2; j <= maxNum; j += i) {
            union(i, j);
        }
    }

    for (const num of nums) {
        const root = find(num);
        for (const other of nums) {
            if (find(other) !== root) {
                return false;
            }
        }
    }

    return true;
}