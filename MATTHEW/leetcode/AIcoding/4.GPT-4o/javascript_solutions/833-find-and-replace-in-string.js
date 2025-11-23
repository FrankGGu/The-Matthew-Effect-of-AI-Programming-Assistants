var findReplaceString = function(S, indexes, sources, targets) {
    let result = '';
    let map = new Map();

    for (let i = 0; i < indexes.length; i++) {
        map.set(indexes[i], { source: sources[i], target: targets[i] });
    }

    for (let i = 0; i < S.length; i++) {
        if (map.has(i)) {
            let { source, target } = map.get(i);
            if (S.substring(i, i + source.length) === source) {
                result += target;
                i += source.length - 1;
                continue;
            }
        }
        result += S[i];
    }

    return result;
};