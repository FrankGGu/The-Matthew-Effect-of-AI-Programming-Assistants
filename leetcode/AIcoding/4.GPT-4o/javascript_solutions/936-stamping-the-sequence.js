var movesToStamp = function(stamp, target) {
    const n = target.length, m = stamp.length;
    let visited = new Array(n).fill(false);
    let toStamp = new Set();
    let res = [];

    const canStamp = (i) => {
        let can = false;
        for (let j = 0; j < m; j++) {
            if (target[i + j] === '?') continue;
            if (stamp[j] !== target[i + j]) return false;
        }
        return true;
    };

    const doStamp = (i) => {
        for (let j = 0; j < m; j++) {
            if (target[i + j] !== '?') {
                target[i + j] = '?';
                toStamp.delete(i + j);
            }
        }
    };

    for (let i = 0; i < n; i++) {
        if (target[i] !== '?') toStamp.add(i);
    }

    let stamped = false;
    while (toStamp.size > 0) {
        stamped = false;
        for (let i = 0; i <= n - m; i++) {
            if (canStamp(i)) {
                doStamp(i);
                res.push(i);
                stamped = true;
            }
        }
        if (!stamped) break;
    }

    if (toStamp.size > 0) return [];

    return res.reverse();
};