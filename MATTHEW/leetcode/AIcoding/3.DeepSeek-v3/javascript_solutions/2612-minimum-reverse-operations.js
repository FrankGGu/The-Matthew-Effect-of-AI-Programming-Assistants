var minReverseOperations = function(n, p, banned, k) {
    const res = new Array(n).fill(-1);
    const bannedSet = new Set(banned);
    if (bannedSet.has(p)) {
        return res;
    }
    res[p] = 0;
    const queue = [p];
    const visited = new Set();
    visited.add(p);
    const available = new Set();
    for (let i = 0; i < n; i++) {
        if (!bannedSet.has(i)) {
            available.add(i);
        }
    }
    available.delete(p);

    while (queue.length > 0) {
        const current = queue.shift();
        const left = Math.max(0, current - k + 1);
        const right = Math.min(n - k, current);
        const start = left + (current - left) - (k - 1);
        for (let i = start; i <= right; i++) {
            const end = i + k - 1;
            const reversedPos = i + (end - current);
            if (available.has(reversedPos)) {
                res[reversedPos] = res[current] + 1;
                queue.push(reversedPos);
                available.delete(reversedPos);
            }
        }
    }
    return res;
};