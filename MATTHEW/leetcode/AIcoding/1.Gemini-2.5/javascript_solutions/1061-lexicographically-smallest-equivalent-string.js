var smallestEquivalentString = function(s1, s2, baseStr) {
    const parent = Array(26).fill(0).map((_, i) => i);

    const find = (i) => {
        if (parent[i] === i) {
            return i;
        }
        parent[i] = find(parent[i]);
        return parent[i];
    };

    const union = (i, j) => {
        let rootI = find(i);
        let rootJ = find(j);

        if (rootI !== rootJ) {
            if (rootI < rootJ) {
                parent[rootJ] = rootI;
            } else {
                parent[rootI] = rootJ;
            }
        }
    };

    for (let i = 0; i < s1.length; i++) {
        const charCode1 = s1.charCodeAt(i) - 'a'.charCodeAt(0);
        const charCode2 = s2.charCodeAt(i) - 'a'.charCodeAt(0);
        union(charCode1, charCode2);
    }

    let result = [];
    for (let i = 0; i < baseStr.length; i++) {
        const charCode = baseStr.charCodeAt(i) - 'a'.charCodeAt(0);
        const rootCharCode = find(charCode);
        result.push(String.fromCharCode(rootCharCode + 'a'.charCodeAt(0)));
    }

    return result.join('');
};