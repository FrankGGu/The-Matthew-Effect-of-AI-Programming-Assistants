int addRungs(int* rungs, int rungsSize, int dist) {
    int count = 0;
    int current = 0;

    for (int i = 0; i < rungsSize; i++) {
        int gap = rungs[i] - current;
        if (gap > dist) {
            count += (gap - 1) / dist;
        }
        current = rungs[i];
    }

    return count;
}