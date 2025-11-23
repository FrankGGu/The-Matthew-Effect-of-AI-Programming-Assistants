var smallestEquivalentString = function(s1, s2, baseStr) {
    const parent = Array.from({ length: 26 }, (_, i) => i);

    function find(x) {
        if (parent[x] !== x) {
            parent[x] = find(parent[x]);
        }
        return parent[x];
    }

    function union(x, y) {
        const rootX = find(x);
        const rootY = find(y);
        if (rootX !== rootY) {
            if (rootX < rootY) {
                parent[rootY] = rootX;
            } else {
                parent[rootX] = rootY;
            }
        }
    }

    for (let i = 0; i < s1.length; i++) {
        const charCode1 = s1.charCodeAt(i) - 'a'.charCodeAt(0);
        const charCode2 = s2.charCodeAt(i) - 'a'.charCodeAt(0);
        union(charCode1, charCode2);
    }

    let result = "";
    for (let i = 0; i < baseStr.length; i++) {
        const charCode = baseStr.charCodeAt(i) - 'a'.charCodeAt(0);
        result += String.fromCharCode(find(charCode) + 'a'.charCodeAt(0));
    }

    return result;
};