var numberOfWeeks = function(milestones) {
    let sum = 0;
    let max = 0;
    for (let milestone of milestones) {
        sum += milestone;
        max = Math.max(max, milestone);
    }
    let remaining = sum - max;
    if (max > remaining) {
        return 2 * remaining + 1;
    } else {
        return sum;
    }
};