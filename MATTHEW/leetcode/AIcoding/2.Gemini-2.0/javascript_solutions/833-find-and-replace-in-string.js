var findReplaceString = function(s, indices, sources, targets) {
    const n = s.length;
    const m = indices.length;
    const replacements = new Array(n).fill(null);

    for (let i = 0; i < m; i++) {
        const index = indices[i];
        const source = sources[i];
        const target = targets[i];

        if (s.substring(index, index + source.length) === source) {
            replacements[index] = { sourceLength: source.length, target };
        }
    }

    let result = "";
    let i = 0;
    while (i < n) {
        if (replacements[i] !== null) {
            result += replacements[i].target;
            i += replacements[i].sourceLength;
        } else {
            result += s[i];
            i++;
        }
    }

    return result;
};