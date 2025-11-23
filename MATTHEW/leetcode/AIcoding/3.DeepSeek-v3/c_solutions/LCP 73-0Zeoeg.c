int adventureCamp(char** expeditions, int expeditionsSize) {
    int maxNew = 0;
    int res = -1;
    char visited[1000][51] = {0};
    int visitedCount = 0;

    char* startCamp = expeditions[0];
    if (startCamp[0] != '\0') {
        char* token = strtok(startCamp, "->");
        while (token != NULL) {
            strcpy(visited[visitedCount++], token);
            token = strtok(NULL, "->");
        }
    }

    for (int i = 1; i < expeditionsSize; i++) {
        if (expeditions[i][0] == '\0') continue;

        int newCount = 0;
        char temp[1001];
        strcpy(temp, expeditions[i]);
        char* token = strtok(temp, "->");

        while (token != NULL) {
            int found = 0;
            for (int j = 0; j < visitedCount; j++) {
                if (strcmp(visited[j], token) == 0) {
                    found = 1;
                    break;
                }
            }
            if (!found) {
                strcpy(visited[visitedCount++], token);
                newCount++;
            }
            token = strtok(NULL, "->");
        }

        if (newCount > maxNew) {
            maxNew = newCount;
            res = i;
        }
    }

    return res;
}