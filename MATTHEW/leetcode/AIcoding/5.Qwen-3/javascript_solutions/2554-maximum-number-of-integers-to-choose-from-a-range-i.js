function maxCount(banned, n, maxSum) {
    const set = new Set(banned);
    let count = 0;
    let sum = 0;
    for (let i = 1; i <= n; i++) {
        if (!set.has(i)) {
            if (sum + i <= maxSum) {
                count++;
                sum += i;
            } else {
                break;
            }
        }
    }
    return count;
}