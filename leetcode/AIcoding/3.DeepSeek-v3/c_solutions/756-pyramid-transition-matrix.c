int allowedSize;
int allowedColSize;
char ***allowed;
int pyramidSize;

int dfs(char *bottom, int idx, char *next) {
    if (strlen(bottom) == 1) return 1;
    if (idx == strlen(bottom) - 1) return dfs(next, 0, (char*)calloc(strlen(next)-1, sizeof(char)));

    char key[3] = {bottom[idx], bottom[idx+1], '\0'};
    for (int i = 0; i < allowedSize; i++) {
        if (strncmp(allowed[i][0], key, 2) == 0) {
            next[idx] = allowed[i][1][0];
            if (dfs(bottom, idx+1, next)) return 1;
        }
    }
    return 0;
}

bool pyramidTransition(char *bottom, char **allowedList, int allowedListSize) {
    allowedSize = allowedListSize;
    allowedColSize = 3;
    pyramidSize = strlen(bottom);

    allowed = (char***)malloc(allowedSize * sizeof(char**));
    for (int i = 0; i < allowedSize; i++) {
        allowed[i] = (char**)malloc(allowedColSize * sizeof(char*));
        for (int j = 0; j < allowedColSize; j++) {
            allowed[i][j] = (char*)malloc(2 * sizeof(char));
        }
        allowed[i][0][0] = allowedList[i][0];
        allowed[i][0][1] = allowedList[i][1];
        allowed[i][0][2] = '\0';
        allowed[i][1][0] = allowedList[i][2];
        allowed[i][1][1] = '\0';
    }

    char *next = (char*)calloc(pyramidSize-1, sizeof(char));
    int result = dfs(bottom, 0, next);

    for (int i = 0; i < allowedSize; i++) {
        for (int j = 0; j < allowedColSize; j++) {
            free(allowed[i][j]);
        }
        free(allowed[i]);
    }
    free(allowed);
    free(next);

    return result;
}