var minTimeToBreakLocks = function(locks, keys) {
    let time = 0;
    const n = locks.length;
    const sortedLocks = [...locks].sort((a, b) => a - b);
    const sortedKeys = [...keys].sort((a, b) => a - b);

    for (let i = 0; i < n; i++) {
        time = Math.max(time, Math.abs(sortedLocks[i] - sortedKeys[i]));
    }

    return time;
};