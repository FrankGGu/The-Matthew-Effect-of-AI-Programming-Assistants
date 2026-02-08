var maxDepth = function(s) {
    let depth = 0;
    let max = 0;
    for (let char of s) {
        if (char === '(') {
            depth++;
            if (depth > max) {
                max = depth;
            }
        } else if (char === ')') {
            depth--;
        }
    }
    return max;
};