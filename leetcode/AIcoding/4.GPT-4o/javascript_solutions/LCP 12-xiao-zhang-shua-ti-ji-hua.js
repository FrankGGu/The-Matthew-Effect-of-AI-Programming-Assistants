function canCompletePlan(n, m, a) {
    let totalDays = 0;
    for (let i = 0; i < n; i++) {
        totalDays += Math.ceil(a[i] / m);
    }
    return totalDays <= n;
}