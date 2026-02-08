var maxDepth = function(s) {
    let depth1 = 0, depth2 = 0, currDepth1 = 0, currDepth2 = 0;
    for (let char of s) {
        if (char === '(') {
            currDepth1++;
            depth1 = Math.max(depth1, currDepth1);
        } else if (char === ')') {
            currDepth1--;
        } else if (char === '[') {
            currDepth2++;
            depth2 = Math.max(depth2, currDepth2);
        } else if (char === ']') {
            currDepth2--;
        }
    }
    return [depth1, depth2];
};