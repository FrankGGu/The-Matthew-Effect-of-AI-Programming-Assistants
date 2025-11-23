class DSU {
    constructor(n) {
        this.parent = Array.from({ length: n }, (_, i) => i);
        this.component_and_value = Array(n).fill(-1);
    }

    find(i) {
        if (this.parent[i] === i) {
            return i;
        }
        this.parent[i] = this.find(this.parent[i]);
        return this.parent[i];
    }

    union(u, v, weight) {
        let root_u = this.find(u);
        let root_v = this.find(v);

        if (root_u !== root_v) {
            this.parent[root_v] = root_u;

            let val_u = this.component_and_value[root_u];
            let val_v = this.component_and_value[root_v];

            let new_val = weight;
            if (val_u !== -1) {
                new_val &= val_u;
            }
            if (val_v !== -1) {
                new_val &= val_v;
            }
            this.component_and_value[root_u] = new_val;
        } else {
            let val_u = this.component_and_value[root_u];
            if (val_u === -1) {
                this.component_and_value[root_u] = weight;
            } else {
                this.component_and_value[root_u] &= weight;
            }
        }
    }
}

function minimumCostWalk(n, edges, queries) {
    const dsu = new DSU(n);

    for (const [u, v, weight] of edges) {
        dsu.union(u, v, weight);
    }

    const results = [];
    for (const [s, t] of queries) {
        const root_s = dsu.find(s);
        const root_t = dsu.find(t);

        if (root_s === root_t) {
            results.push(dsu.component_and_value[root_s]);
        } else {
            results.push(-1);
        }
    }

    return results;
}