bool wordPattern(char* pattern, char* s) {
    char *map[26] = {NULL};
    char *token, *context = NULL;
    int i = 0;
    char *visited[26] = {NULL};

    token = strtok_r(s, " ", &context);
    while (token && pattern[i]) {
        int idx = pattern[i] - 'a';

        if (map[idx] == NULL) {
            for (int j = 0; j < 26; j++) {
                if (visited[j] != NULL && strcmp(visited[j], token) == 0) {
                    return false;
                }
            }
            map[idx] = token;
            visited[idx] = token;
        } else {
            if (strcmp(map[idx], token) != 0) {
                return false;
            }
        }

        i++;
        token = strtok_r(NULL, " ", &context);
    }

    if (token || pattern[i]) {
        return false;
    }

    return true;
}