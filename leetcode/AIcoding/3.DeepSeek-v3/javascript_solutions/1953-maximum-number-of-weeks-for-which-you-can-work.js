var numberOfWeeks = function(milestones) {
    let max = Math.max(...milestones);
    let sum = milestones.reduce((a, b) => a + b, 0);
    if (max <= sum - max + 1) {
        return sum;
    } else {
        return 2 * (sum - max) + 1;
    }
};