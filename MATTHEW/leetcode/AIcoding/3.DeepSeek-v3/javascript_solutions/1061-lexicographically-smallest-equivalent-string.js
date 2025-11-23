var smallestEquivalentString = function(s1, s2, baseStr) {
    const parent = {};

    for (let i = 0; i < 26; i++) {
        const char = String.fromCharCode('a'.charCodeAt(0) + i);
        parent[char] = char;
    }

    const find = (x) => {
        if (parent[x] !== x) {
            parent[x] = find(parent[x]);
        }
        return parent[x];
    };

    const union = (x, y) => {
        const rootX = find(x);
        const rootY = find(y);
        if (rootX < rootY) {
            parent[rootY] = rootX;
        } else {
            parent[rootX] = rootY;
        }
    };

    for (let i = 0; i < s1.length; i++) {
        union(s1[i], s2[i]);
    }

    let result = [];
    for (const char of baseStr) {
        result.push(find(char));
    }

    return result.join('');
};