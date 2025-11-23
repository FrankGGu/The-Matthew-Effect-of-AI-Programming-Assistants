function numSimilarGroups(A) {
    const parent = {};

    function find(x) {
        if (parent[x] !== x) {
            parent[x] = find(parent[x]);
        }
        return parent[x];
    }

    function union(x, y) {
        parent[find(x)] = find(y);
    }

    for (let i = 0; i < A.length; i++) {
        parent[A[i]] = A[i];
    }

    for (let i = 0; i < A.length; i++) {
        for (let j = i + 1; j < A.length; j++) {
            let diff = 0;
            for (let k = 0; k < A[i].length && diff <= 2; k++) {
                if (A[i][k] !== A[j][k]) {
                    diff++;
                }
            }
            if (diff <= 2) {
                union(A[i], A[j]);
            }
        }
    }

    const roots = new Set();
    for (let word of A) {
        roots.add(find(word));
    }

    return roots.size;
}