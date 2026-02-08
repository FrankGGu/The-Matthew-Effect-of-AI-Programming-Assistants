var equationsPossible = function(equations) {
    const parent = new Array(26).fill(0).map((_, i) => i);

    function find(x) {
        if (parent[x] === x) {
            return x;
        }
        return parent[x] = find(parent[x]);
    }

    function union(x, y) {
        const rootX = find(x);
        const rootY = find(y);
        if (rootX !== rootY) {
            parent[rootX] = rootY;
        }
    }

    for (const equation of equations) {
        if (equation[1] === '=') {
            const x = equation.charCodeAt(0) - 'a'.charCodeAt(0);
            const y = equation.charCodeAt(3) - 'a'.charCodeAt(0);
            union(x, y);
        }
    }

    for (const equation of equations) {
        if (equation[1] === '!') {
            const x = equation.charCodeAt(0) - 'a'.charCodeAt(0);
            const y = equation.charCodeAt(3) - 'a'.charCodeAt(0);
            if (find(x) === find(y)) {
                return false;
            }
        }
    }

    return true;
};