var maxCount = function(banned, n, maxSum) {
    const bannedSet = new Set(banned);
    let count = 0;
    let sum = 0;

    for (let i = 1; i <= n; i++) {
        if (!bannedSet.has(i) && sum + i <= maxSum) {
            sum += i;
            count++;
        }
    }

    return count;
};