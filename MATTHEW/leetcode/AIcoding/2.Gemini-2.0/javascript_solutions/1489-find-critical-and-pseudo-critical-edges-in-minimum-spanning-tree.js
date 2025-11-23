var findCriticalAndPseudoCriticalEdges = function(n, edges) {
    const m = edges.length;
    for (let i = 0; i < m; i++) {
        edges[i].push(i);
    }
    edges.sort((a, b) => a[2] - b[2]);

    const findMSTWeight = (mustInclude, mustExclude) => {
        let weight = 0;
        const parent = Array(n).fill(0).map((_, i) => i);

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
                return true;
            }
            return false;
        };

        let count = 0;
        if (mustInclude !== -1) {
            union(edges[mustInclude][0], edges[mustInclude][1]);
            weight += edges[mustInclude][2];
            count++;
        }

        for (let i = 0; i < m; i++) {
            if (i === mustExclude) continue;
            if (union(edges[i][0], edges[i][1])) {
                weight += edges[i][2];
                count++;
            }
        }

        for (let i = 0; i < n; i++) {
            find(i);
        }

        let connected = true;
        for(let i = 1; i < n; i++){
            if(parent[i] !== parent[0]) {
                connected = false;
                break;
            }
        }

        if (count !== n - 1 || !connected) return Infinity;
        return weight;
    };

    const minWeight = findMSTWeight(-1, -1);

    const critical = [];
    const pseudoCritical = [];

    for (let i = 0; i < m; i++) {
        if (findMSTWeight(-1, i) > minWeight) {
            critical.push(edges[i][3]);
        } else if (findMSTWeight(i, -1) === minWeight) {
            pseudoCritical.push(edges[i][3]);
        }
    }

    return [critical, pseudoCritical];
};