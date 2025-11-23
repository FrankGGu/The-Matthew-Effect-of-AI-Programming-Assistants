int maxWeeks(int* milestones, int milestonesSize) {
    long total = 0, maxMilestone = 0;
    for (int i = 0; i < milestonesSize; i++) {
        total += milestones[i];
        if (milestones[i] > maxMilestone) {
            maxMilestone = milestones[i];
        }
    }
    if (total - maxMilestone >= maxMilestone - 1) {
        return total;
    } else {
        return 2 * (total - maxMilestone) + 1;
    }
}