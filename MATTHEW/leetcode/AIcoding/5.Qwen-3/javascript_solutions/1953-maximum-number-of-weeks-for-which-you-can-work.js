function numberOfWeeks(milestones) {
    let total = 0;
    for (let i = 0; i < milestones.length; i++) {
        total += milestones[i];
    }
    let max = Math.max(...milestones);
    if (max > total - max) {
        return 2 * (total - max) + 1;
    } else {
        return total;
    }
}