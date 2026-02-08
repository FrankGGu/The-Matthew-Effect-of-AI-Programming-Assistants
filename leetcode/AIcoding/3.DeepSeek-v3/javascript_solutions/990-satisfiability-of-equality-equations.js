var equationsPossible = function(equations) {
    const parent = new Array(26).fill(0).map((_, i) => i);

    function find(u) {
        if (parent[u] !== u) {
            parent[u] = find(parent[u]);
        }
        return parent[u];
    }

    for (const eq of equations) {
        if (eq[1] === '=') {
            const u = eq.charCodeAt(0) - 'a'.charCodeAt(0);
            const v = eq.charCodeAt(3) - 'a'.charCodeAt(0);
            const rootU = find(u);
            const rootV = find(v);
            if (rootU !== rootV) {
                parent[rootV] = rootU;
            }
        }
    }

    for (const eq of equations) {
        if (eq[1] === '!') {
            const u = eq.charCodeAt(0) - 'a'.charCodeAt(0);
            const v = eq.charCodeAt(3) - 'a'.charCodeAt(0);
            const rootU = find(u);
            const rootV = find(v);
            if (rootU === rootV) {
                return false;
            }
        }
    }

    return true;
};