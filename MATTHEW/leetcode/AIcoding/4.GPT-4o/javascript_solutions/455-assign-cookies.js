var findContentChildren = function(g, s) {
    g.sort((a, b) => a - b);
    s.sort((a, b) => a - b);
    let child = 0;
    for (let cookie = 0; cookie < s.length && child < g.length; cookie++) {
        if (s[cookie] >= g[child]) {
            child++;
        }
    }
    return child;
};