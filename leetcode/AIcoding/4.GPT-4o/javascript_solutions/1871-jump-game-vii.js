function canReach(s, minJump, maxJump) {
    let n = s.length;
    let reachable = 0;
    let lastReachable = 0;

    for (let i = 0; i < n; i++) {
        if (i > reachable) return false;
        if (s[i] === '0') {
            if (i >= minJump) {
                lastReachable = Math.max(lastReachable, i + maxJump);
            }
            if (i >= lastReachable) {
                reachable = lastReachable;
            }
        }
    }
    return reachable >= n - 1;
}