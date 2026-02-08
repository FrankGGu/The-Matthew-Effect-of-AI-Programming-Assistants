int garbageCollection(char** garbage, int garbageSize, int* travel, int travelSize) {
    int time = 0;
    int lastM = -1, lastP = -1, lastG = -1;

    for (int i = 0; i < garbageSize; i++) {
        time += strlen(garbage[i]);
        for (int j = 0; garbage[i][j] != '\0'; j++) {
            if (garbage[i][j] == 'M') lastM = i;
            else if (garbage[i][j] == 'P') lastP = i;
            else if (garbage[i][j] == 'G') lastG = i;
        }
    }

    for (int i = 1; i < travelSize; i++) {
        travel[i] += travel[i-1];
    }

    if (lastM > 0) time += travel[lastM - 1];
    if (lastP > 0) time += travel[lastP - 1];
    if (lastG > 0) time += travel[lastG - 1];

    return time;
}