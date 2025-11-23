var numberOfWeeks = function(days) {
    const totalDays = days.reduce((a, b) => a + b, 0);
    const maxDays = Math.max(...days);
    return Math.min(totalDays, 2 * (totalDays - maxDays) + 1);
};