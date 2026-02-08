function minInitialEnergy(tasks) {
    let total = 0;
    let maxDiff = 0;
    for (let [effort, limit] of tasks) {
        total += effort;
        maxDiff = Math.max(maxDiff, limit - effort);
    }
    return total + maxDiff;
}