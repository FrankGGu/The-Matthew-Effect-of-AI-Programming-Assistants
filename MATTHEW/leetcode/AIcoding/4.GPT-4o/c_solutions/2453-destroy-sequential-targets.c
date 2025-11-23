int destroyTargets(int* targets, int targetsSize, int space) {
    int count[100001] = {0};
    for (int i = 0; i < targetsSize; i++) {
        count[targets[i] % space]++;
    }
    int maxTargets = 0, result = 0;
    for (int i = 0; i < space; i++) {
        if (count[i] > maxTargets) {
            maxTargets = count[i];
            result = i;
        }
    }
    return result;
}