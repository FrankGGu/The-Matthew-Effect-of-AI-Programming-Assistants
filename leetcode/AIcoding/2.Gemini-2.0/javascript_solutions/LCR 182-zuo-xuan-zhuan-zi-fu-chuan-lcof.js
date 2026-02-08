var dynamicPassword = function(password, k) {
    const n = password.length;
    k = k % n;
    if (k === 0) return 0;

    let sum = 0;
    for (let i = 0; i < n; i++) {
        sum += password[i];
    }

    let maxDiff = -Infinity;
    let currentSum = 0;

    for (let i = 0; i < k; i++) {
        currentSum += password[i];
    }

    maxDiff = Math.max(maxDiff, currentSum - (sum - currentSum));

    for (let i = k; i < n; i++) {
        currentSum += password[i];
        currentSum -= password[i - k];
        maxDiff = Math.max(maxDiff, currentSum - (sum - currentSum));
    }

    return maxDiff;
};