var maxCount = function(n, banned, maxSum) {
    let count = 0;
    let currentSum = 0;
    const bannedSet = new Set(banned);

    for (let i = 1; i <= n; i++) {
        if (bannedSet.has(i)) {
            continue;
        }

        if (currentSum + i <= maxSum) {
            currentSum += i;
            count++;
        } else {
            break;
        }
    }

    return count;
};