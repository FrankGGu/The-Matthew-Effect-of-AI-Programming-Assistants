var findContentChildren = function(g, s) {
    g.sort((a, b) => a - b);
    s.sort((a, b) => a - b);

    let childIdx = 0;
    let cookieIdx = 0;
    let contentChildren = 0;

    while (childIdx < g.length && cookieIdx < s.length) {
        if (s[cookieIdx] >= g[childIdx]) {
            contentChildren++;
            childIdx++;
            cookieIdx++;
        } else {
            cookieIdx++;
        }
    }

    return contentChildren;
};