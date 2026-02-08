var numberOfWeeks = function(milestones) {
    let sum = 0;
    let max = 0;

    for (let i = 0; i < milestones.length; i++) {
        sum += milestones[i];
        if (milestones[i] > max) {
            max = milestones[i];
        }
    }

    if (2 * max <= sum + 1) {
        return sum;
    } else {
        return 2 * (sum - max) + 1;
    }
};