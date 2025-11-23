var movesToStamp = function(stamp, target) {
    const s = stamp.split('');
    const t = target.split('');
    const m = s.length;
    const n = t.length;
    const res = [];
    const visited = new Array(n).fill(false);
    let stars = 0;

    while (stars < n) {
        let done = false;
        for (let i = 0; i <= n - m; i++) {
            if (!visited[i] && canReplace(i, s, t)) {
                stars = replace(i, m, t, stars);
                visited[i] = true;
                res.push(i);
                done = true;
                if (stars === n) break;
            }
        }
        if (!done) return [];
    }

    return res.reverse();
};

function canReplace(pos, s, t) {
    for (let i = 0; i < s.length; i++) {
        if (t[pos + i] !== '*' && t[pos + i] !== s[i]) {
            return false;
        }
    }
    return true;
}

function replace(pos, len, t, count) {
    for (let i = 0; i < len; i++) {
        if (t[pos + i] !== '*') {
            t[pos + i] = '*';
            count++;
        }
    }
    return count;
}