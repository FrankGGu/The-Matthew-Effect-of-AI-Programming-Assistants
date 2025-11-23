function isSimilar(s1, s2) {
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
}

class DSU {
    constructor(n) {
        this.parent = Array.from({ length: n }, (_, i) => i);
        this.numGroups = n;
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
            this.numGroups--;
            return true;
        }
        return false;
    }
}

var numSimilarGroups = function(strs) {
    const n = strs.length;
    const dsu = new DSU(n);

    for (let i = 0; i < n; i++) {
        for (let j = i + 1; j < n; j++) {
            if (isSimilar(strs[i], strs[j])) {
                dsu.union(i, j);
            }
        }
    }

    return dsu.numGroups;
};