class UnionFind {
    constructor(size) {
        this.parent = Array.from({ length: size }, (_, i) => i);
    }

    find(x) {
        if (this.parent[x] !== x) {
            this.parent[x] = this.find(this.parent[x]);
        }
        return this.parent[x];
    }

    union(x, y) {
        const rootX = this.find(x);
        const rootY = this.find(y);
        if (rootX !== rootY) {
            this.parent[rootY] = rootX;
        }
    }
}

var gcdSort = function(nums) {
    const maxNum = Math.max(...nums);
    const uf = new UnionFind(maxNum + 1);

    for (let i = 0; i < nums.length; i++) {
        for (let j = i + 1; j < nums.length; j++) {
            if (gcd(nums[i], nums[j]) > 1) {
                uf.union(nums[i], nums[j]);
            }
        }
    }

    const groups = {};
    for (let num of nums) {
        const root = uf.find(num);
        if (!groups[root]) {
            groups[root] = [];
        }
        groups[root].push(num);
    }

    for (let key in groups) {
        groups[key].sort((a, b) => a - b);
    }

    const sorted = [];
    for (let num of nums) {
        sorted.push(groups[uf.find(num)].shift());
    }

    return sorted.join('') === nums.sort((a, b) => a - b).join('');
};

function gcd(a, b) {
    while (b) {
        [a, b] = [b, a % b];
    }
    return a;
}