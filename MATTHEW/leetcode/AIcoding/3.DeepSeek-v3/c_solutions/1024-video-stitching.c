int videoStitching(int** clips, int clipsSize, int* clipsColSize, int time) {
    int maxReach[time + 1];
    for (int i = 0; i <= time; i++) {
        maxReach[i] = 0;
    }

    for (int i = 0; i < clipsSize; i++) {
        int start = clips[i][0];
        int end = clips[i][1];
        if (start <= time) {
            if (end > maxReach[start]) {
                maxReach[start] = end;
            }
        }
    }

    int currentEnd = 0, farthestEnd = 0, count = 0;
    for (int i = 0; i <= time; i++) {
        if (i > farthestEnd) {
            return -1;
        }
        if (i > currentEnd) {
            count++;
            currentEnd = farthestEnd;
        }
        if (maxReach[i] > farthestEnd) {
            farthestEnd = maxReach[i];
        }
        if (farthestEnd >= time) {
            return count + 1;
        }
    }

    return -1;
}