function smallestEquivalentString(A, B, S) {
    const parent = Array(26).fill(0).map((_, i) => i);

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
        if (rootX !== rootY) {
            parent[rootY] = rootX;
        }
    }

    for (let i = 0; i < A.length; i++) {
        const a = A[i].charCodeAt(0) - 'a'.charCodeAt(0);
        const b = B[i].charCodeAt(0) - 'a'.charCodeAt(0);
        union(a, b);
    }

    let result = '';
    for (const c of S) {
        const index = c.charCodeAt(0) - 'a'.charCodeAt(0);
        const root = find(index);
        result += String.fromCharCode(root + 'a'.charCodeAt(0));
    }

    return result;
}