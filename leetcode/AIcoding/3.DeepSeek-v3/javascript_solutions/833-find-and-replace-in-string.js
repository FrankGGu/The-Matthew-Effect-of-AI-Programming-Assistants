var findReplaceString = function(s, indices, sources, targets) {
    let result = [];
    let i = 0;
    let n = s.length;
    let operations = [];

    for (let j = 0; j < indices.length; j++) {
        operations.push({ index: indices[j], source: sources[j], target: targets[j] });
    }

    operations.sort((a, b) => a.index - b.index);

    let k = 0;
    while (i < n) {
        if (k < operations.length && i === operations[k].index) {
            let source = operations[k].source;
            let target = operations[k].target;
            let len = source.length;
            if (s.substr(i, len) === source) {
                result.push(target);
                i += len;
            } else {
                result.push(s[i]);
                i++;
            }
            k++;
        } else {
            result.push(s[i]);
            i++;
        }
    }

    return result.join('');
};