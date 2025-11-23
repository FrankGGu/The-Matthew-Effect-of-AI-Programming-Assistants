int flipgame(int* fronts, int frontsSize, int* backs, int backsSize) {
    int forbidden[2001] = {0};
    for (int i = 0; i < frontsSize; i++) {
        if (fronts[i] == backs[i]) {
            forbidden[fronts[i]] = 1;
        }
    }

    int min_good = INT_MAX;
    for (int i = 0; i < frontsSize; i++) {
        if (!forbidden[fronts[i]]) {
            if (fronts[i] < min_good) {
                min_good = fronts[i];
            }
        }
        if (!forbidden[backs[i]]) {
            if (backs[i] < min_good) {
                min_good = backs[i];
            }
        }
    }

    return min_good == INT_MAX ? 0 : min_good;
}