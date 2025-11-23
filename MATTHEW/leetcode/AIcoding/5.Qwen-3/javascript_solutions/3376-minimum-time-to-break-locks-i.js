function minTimeToBreakLocks(locks, key) {
    const n = locks.length;
    const m = key.length;
    let result = 0;

    for (let i = 0; i < n; i++) {
        let current = 0;
        for (let j = 0; j < m; j++) {
            if (locks[i][j] === key[j]) {
                current++;
            } else {
                break;
            }
        }
        result += current;
    }

    return result;
}