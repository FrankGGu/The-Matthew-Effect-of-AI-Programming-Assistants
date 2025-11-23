int maxConsecutive(int bottom, int top, int[] special, int specialSize) {
    if (specialSize == 0) return top - bottom + 1;

    qsort(special, specialSize, sizeof(int), cmp);

    int maxConsecutiveFloors = 0;

    if (special[0] > bottom) {
        maxConsecutiveFloors = special[0] - bottom;
    }

    for (int i = 1; i < specialSize; i++) {
        int consecutiveFloors = special[i] - special[i - 1] - 1;
        if (consecutiveFloors > maxConsecutiveFloors) {
            maxConsecutiveFloors = consecutiveFloors;
        }
    }

    if (top > special[specialSize - 1]) {
        int consecutiveFloors = top - special[specialSize - 1];
        if (consecutiveFloors > maxConsecutiveFloors) {
            maxConsecutiveFloors = consecutiveFloors;
        }
    }

    return maxConsecutiveFloors;
}

int cmp(const void *a, const void *b) {
    return (*(int *)a - *(int *)b);
}