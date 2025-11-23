function maxDepthAfterSplit(s) {
    let depth = 0;
    let result = 0;
    for (let i = 0; i < s.length; i++) {
        if (s[i] === '(') {
            depth++;
            result = Math.max(result, depth);
        } else {
            depth--;
        }
    }
    return result;
}