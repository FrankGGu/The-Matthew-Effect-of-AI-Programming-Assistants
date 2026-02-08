var smallestEquivalentString = function(s1, s2, baseStr) {
    const parent = Array.from({ length: 26 }, (_, i) => String.fromCharCode(i + 97));

    const find = (x) => {
        if (parent[x] !== String.fromCharCode(x + 97)) {
            parent[x] = find(parent[x].charCodeAt(0) - 97);
        }
        return parent[x];
    };

    const union = (x, y) => {
        const rootX = find(x);
        const rootY = find(y);
        if (rootX < rootY) {
            parent[rootY.charCodeAt(0) - 97] = rootX;
        } else {
            parent[rootX.charCodeAt(0) - 97] = rootY;
        }
    };

    for (let i = 0; i < s1.length; i++) {
        union(s1.charCodeAt(i) - 97, s2.charCodeAt(i) - 97);
    }

    let result = '';
    for (let char of baseStr) {
        result += find(char.charCodeAt(0) - 97);
    }
    return result;
};