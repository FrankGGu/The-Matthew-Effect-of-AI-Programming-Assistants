var maxDepthAfterSplit = function(seq) {
    let depth = 0;
    let result = [];
    for (let i = 0; i < seq.length; i++) {
        if (seq[i] === '(') {
            depth++;
            result.push(depth % 2);
        } else {
            result.push(depth % 2);
            depth--;
        }
    }
    return result;
};