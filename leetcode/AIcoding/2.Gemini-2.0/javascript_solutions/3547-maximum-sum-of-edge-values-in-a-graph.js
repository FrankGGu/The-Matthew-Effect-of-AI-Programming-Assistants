var maxEdgeValueQueries = function(edges, values) {
    const n = values.length;
    const m = edges.length;
    const parent = Array(n).fill(0).map((_, i) => i);
    const edgeMap = new Map();

    function find(i) {
        if (parent[i] === i) {
            return i;
        }
        return parent[i] = find(parent[i]);
    }

    function union(i, j, val) {
        let rootI = find(i);
        let rootJ = find(j);
        if (rootI !== rootJ) {
            parent[rootI] = rootJ;
            edgeMap.set([i,j].sort((a,b)=>a-b).join(','), val);
            edgeMap.set([j,i].sort((a,b)=>a-b).join(','), val);
        }
    }

    for (let i = 0; i < m; i++) {
        const [u, v] = edges[i];
        union(u, v, values[i]);
    }

    const result = [];
    for (let i = 0; i < m; i++) {
        let maxSum = -1;
        for (let j = 0; j < m; j++) {
            let sum = 0;
            let u = edges[i][0];
            let v = edges[i][1];
            let u2 = edges[j][0];
            let v2 = edges[j][1];
            if (find(u) === find(v) && find(u2) === find(v2)) {
                sum = values[i] + values[j];
            } else {
                continue;
            }

            if(edgeMap.has([u,v].sort((a,b)=>a-b).join(',')) && edgeMap.has([u2,v2].sort((a,b)=>a-b).join(',')) && ([u,v].sort((a,b)=>a-b).join(',') === [u2,v2].sort((a,b)=>a-b).join(','))){
                sum = values[i];
            }
            maxSum = Math.max(maxSum, sum);
        }
        result.push(maxSum);
    }

    return result;
};