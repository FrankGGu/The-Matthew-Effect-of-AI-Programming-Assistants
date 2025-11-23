var findPoisonedDuration = function(timeSeries, duration) {
    if (timeSeries.length === 0) {
        return 0;
    }

    let totalPoisonedTime = 0;

    for (let i = 0; i < timeSeries.length - 1; i++) {
        const currentAttackTime = timeSeries[i];
        const nextAttackTime = timeSeries[i + 1];

        totalPoisonedTime += Math.min(duration, nextAttackTime - currentAttackTime);
    }

    totalPoisonedTime += duration;

    return totalPoisonedTime;
};