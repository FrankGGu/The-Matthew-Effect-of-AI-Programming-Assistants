var removeStones = function(stones) {
    const find = (x) => {
        if (parent[x] !== x) {
            parent[x] = find(parent[x]);
        }
        return parent[x];
    };

    const union = (x, y) => {
        const rootX = find(x);
        const rootY = find(y);
        if (rootX !== rootY) {
            parent[rootY] = rootX;
            count--;
        }
    };

    const parent = {};
    let count = 0;

    for (const [x, y] of stones) {
        const px = `x${x}`;
        const py = `y${y}`;
        if (!(px in parent)) {
            parent[px] = px;
            count++;
        }
        if (!(py in parent)) {
            parent[py] = py;
            count++;
        }
        union(px, py);
    }

    return stones.length - count;
};