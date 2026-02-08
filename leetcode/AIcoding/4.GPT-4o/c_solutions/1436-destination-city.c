char *destCity(char ***paths, int pathsSize, int *pathsColSize) {
    int hashMap[1001] = {0};
    for (int i = 0; i < pathsSize; i++) {
        hashMap[(int)(*paths)[i][0]]++;
        hashMap[(int)(*paths)[i][1]]--;
    }
    for (int i = 0; i < pathsSize; i++) {
        if (hashMap[(int)(*paths)[i][1]] == -1) {
            return (*paths)[i][1];
        }
    }
    return NULL;
}