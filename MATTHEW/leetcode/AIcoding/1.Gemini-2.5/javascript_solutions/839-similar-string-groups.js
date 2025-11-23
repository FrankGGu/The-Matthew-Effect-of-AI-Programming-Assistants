class UnionFind {
    constructor(n) {
        this.parent = Array.from({ length: n }, (_, i) => i);
        this.count = n;
    }

    find(i) {
        if (this.parent[i] === i) {
            return i;
        }
        return this.parent[i] = this.find(this.parent[i]);
    }

    union(i, j) {
        let rootI = this.find(i);
        let rootJ = this.find(j);

        if (rootI !== rootJ) {
            this.parent[rootI] = rootJ;
            this.count--;
            return true;
        }
        return false;
    }
}

function numSimilarGroups(strs) {
    const n = strs.length;
    if (n === 0) return 0;
    if (n === 1) return 1;

    const uf = new UnionFind(n);

    const isSimilar = (s1, s2) => {
        let diff = [];
        for (let i = 0; i < s1.length; i++) {
            if (s1[i] !== s2[i]) {
                diff.push(i);
            }
        }

        if (diff.length === 0) {
            return true;
        }
        if (diff.length === 2) {
            return s1[diff[0]] === s2[diff[1]] && s1[diff[1]] === s2[diff[0]];
        }
        return false;
    };

    for (let i = 0; i < n; i++) {
        for (let j = i + 1; j < n; j++) {
            if (isSimilar(strs[i], strs[j])) {
                uf.union(i, j);
            }
        }
    }

    return uf.count;
}