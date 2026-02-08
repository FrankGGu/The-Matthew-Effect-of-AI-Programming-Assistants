var findAllPeople = function(n, meetings, firstPerson) {
    const parent = new Array(n).fill(0).map((_, i) => i);
    const rank = new Array(n).fill(0);

    parent[firstPerson] = 0;

    function find(u) {
        if (parent[u] !== u) {
            parent[u] = find(parent[u]);
        }
        return parent[u];
    }

    function union(u, v) {
        let rootU = find(u);
        let rootV = find(v);
        if (rootU !== rootV) {
            if (rank[rootU] > rank[rootV]) {
                parent[rootV] = rootU;
            } else if (rank[rootU] < rank[rootV]) {
                parent[rootU] = rootV;
            } else {
                parent[rootV] = rootU;
                rank[rootU]++;
            }
        }
    }

    meetings.sort((a, b) => a[2] - b[2]);

    let i = 0;
    const m = meetings.length;

    while (i < m) {
        let j = i;
        while (j < m && meetings[j][2] === meetings[i][2]) {
            j++;
        }

        const time = meetings[i][2];
        const people = new Set();

        for (let k = i; k < j; k++) {
            const [x, y, _] = meetings[k];
            union(x, y);
            people.add(x);
            people.add(y);
        }

        for (const p of people) {
            if (find(p) !== 0) {
                parent[p] = p;
            }
        }

        i = j;
    }

    const result = [];
    for (let p = 0; p < n; p++) {
        if (find(p) === 0) {
            result.push(p);
        }
    }

    return result;
};