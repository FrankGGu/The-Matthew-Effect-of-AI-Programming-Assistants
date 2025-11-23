int addRungs(int* rungs, int rungsSize, int dist) {
    int count = 0, current = 0;
    for (int i = 0; i < rungsSize; i++) {
        while (rungs[i] - current > dist) {
            current += dist;
            count++;
        }
        current = rungs[i];
    }
    return count;
}