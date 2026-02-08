var equationsPossible = function(equations) {
    const parent = Array.from({ length: 26 }, (_, i) => i);

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
            parent[rootX] = rootY;
        }
    };

    for (const eq of equations) {
        if (eq[1] === '=') {
            union(eq.charCodeAt(0) - 'a'.charCodeAt(0), eq.charCodeAt(3) - 'a'.charCodeAt(0));
        }
    }

    for (const eq of equations) {
        if (eq[1] === '!') {
            if (find(eq.charCodeAt(0) - 'a'.charCodeAt(0)) === find(eq.charCodeAt(3) - 'a'.charCodeAt(0))) {
                return false;
            }
        }
    }

    return true;
};