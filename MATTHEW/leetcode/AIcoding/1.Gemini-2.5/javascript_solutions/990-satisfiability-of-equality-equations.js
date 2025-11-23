class UnionFind {
    constructor(size) {
        this.parent = new Array(size);
        for (let i = 0; i < size; i++) {
            this.parent[i] = i;
        }
    }

    find(i) {
        if (this.parent[i] === i) {
            return i;
        }
        this.parent[i] = this.find(this.parent[i]);
        return this.parent[i];
    }

    union(i, j) {
        const rootI = this.find(i);
        const rootJ = this.find(j);
        if (rootI !== rootJ) {
            this.parent[rootJ] = rootI;
            return true;
        }
        return false;
    }
}

var equationsPossible = function(equations) {
    const uf = new UnionFind(26);

    for (const eq of equations) {
        if (eq[1] === '=') {
            const char1 = eq.charCodeAt(0) - 'a'.charCodeAt(0);
            const char2 = eq.charCodeAt(3) - 'a'.charCodeAt(0);
            uf.union(char1, char2);
        }
    }

    for (const eq of equations) {
        if (eq[1] === '!') {
            const char1 = eq.charCodeAt(0) - 'a'.charCodeAt(0);
            const char2 = eq.charCodeAt(3) - 'a'.charCodeAt(0);
            if (uf.find(char1) === uf.find(char2)) {
                return false;
            }
        }
    }

    return true;
};