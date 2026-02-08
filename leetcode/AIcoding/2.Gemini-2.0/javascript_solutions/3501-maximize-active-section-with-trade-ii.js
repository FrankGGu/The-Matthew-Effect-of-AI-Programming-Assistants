var maximizeActiveSections = function(charge, time) {
    let n = charge.length;
    let extra = 0;
    for (let i = 0; i < n; i++) {
        extra += Math.max(0, time - charge[i] - 1);
    }
    let ans = 0;
    let sum = 0;
    for (let i = 0; i < time; i++) {
        sum += charge[i];
    }
    ans = sum;
    for (let i = time; i < n; i++) {
        sum += charge[i] - charge[i - time];
        ans = Math.max(ans, sum);
    }
    return Math.min(n, ans + extra);
};