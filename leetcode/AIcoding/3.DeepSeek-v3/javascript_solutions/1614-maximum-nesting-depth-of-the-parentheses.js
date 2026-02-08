var maxDepth = function(s) {
    let maxDepth = 0;
    let currentDepth = 0;
    for (let char of s) {
        if (char === '(') {
            currentDepth++;
            if (currentDepth > maxDepth) {
                maxDepth = currentDepth;
            }
        } else if (char === ')') {
            currentDepth--;
        }
    }
    return maxDepth;
};