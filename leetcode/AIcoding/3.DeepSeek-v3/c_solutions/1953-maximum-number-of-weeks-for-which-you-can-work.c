int numberOfWeeks(int* milestones, int milestonesSize) {
    long long max = 0;
    long long sum = 0;

    for (int i = 0; i < milestonesSize; i++) {
        if (milestones[i] > max) {
            max = milestones[i];
        }
        sum += milestones[i];
    }

    long long rest = sum - max;

    if (max > rest + 1) {
        return rest * 2 + 1;
    } else {
        return sum;
    }
}