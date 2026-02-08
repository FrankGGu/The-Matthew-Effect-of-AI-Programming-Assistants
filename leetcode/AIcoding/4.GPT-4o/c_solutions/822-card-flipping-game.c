int flipgame(int* fronts, int frontsSize, int* backs, int backsSize) {
    int bad[201] = {0}, min = 201;

    for (int i = 0; i < frontsSize; i++) {
        if (fronts[i] == backs[i]) {
            bad[fronts[i]] = 1;
        }
    }

    for (int i = 0; i < frontsSize; i++) {
        if (!bad[fronts[i]] && fronts[i] < min) {
            min = fronts[i];
        }
        if (!bad[backs[i]] && backs[i] < min) {
            min = backs[i];
        }
    }

    return min == 201 ? 0 : min;
}