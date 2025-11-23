function findReplaceString(s, indices, sources, targets) {
    const map = new Map();
    for (let i = 0; i < indices.length; i++) {
        map.set(indices[i], { source: sources[i], target: targets[i] });
    }
    let result = '';
    let i = 0;
    while (i < s.length) {
        if (map.has(i)) {
            const { source, target } = map.get(i);
            if (s.startsWith(source, i)) {
                result += target;
                i += source.length;
            } else {
                result += s[i];
                i++;
            }
        } else {
            result += s[i];
            i++;
        }
    }
    return result;
}