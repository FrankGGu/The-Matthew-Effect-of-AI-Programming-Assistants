int garbageCollection(char ** garbage, int garbageSize, int* travel, int travelSize) {
    int totalTime = 0;
    int lastMetal = 0, lastPlastic = 0, lastPaper = 0;

    for (int i = 0; i < garbageSize; i++) {
        int len = strlen(garbage[i]);
        totalTime += len;
        if (garbage[i][0] == 'M') lastMetal = i;
        else if (garbage[i][0] == 'P') lastPlastic = i;
        else if (garbage[i][0] == 'G') lastPaper = i;
    }

    for (int i = 0; i < travelSize; i++) {
        totalTime += travel[i];
    }

    if (lastMetal > 0) totalTime += travel[lastMetal - 1];
    if (lastPlastic > 0) totalTime += travel[lastPlastic - 1];
    if (lastPaper > 0) totalTime += travel[lastPaper - 1];

    return totalTime;
}