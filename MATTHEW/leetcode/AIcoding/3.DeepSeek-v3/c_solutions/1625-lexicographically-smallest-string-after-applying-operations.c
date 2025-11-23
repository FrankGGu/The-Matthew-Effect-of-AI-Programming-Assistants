char* findLexSmallestString(char* s, int a, int b) {
    int n = strlen(s);
    char* result = (char*)malloc((n + 1) * sizeof(char));
    strcpy(result, s);

    char* current = (char*)malloc((n + 1) * sizeof(char));
    strcpy(current, s);

    int visited[n];
    for (int i = 0; i < n; i++) visited[i] = 0;

    int start = 0;
    while (!visited[start]) {
        visited[start] = 1;

        for (int add1 = 0; add1 < 10; add1++) {
            for (int add2 = 0; add2 < 10; add2++) {
                for (int i = 0; i < n; i++) {
                    int idx = (start + i) % n;
                    if (i % 2 == 0) {
                        current[idx] = '0' + (s[(i + start) % n] - '0' + add2 * a) % 10;
                    } else {
                        current[idx] = '0' + (s[(i + start) % n] - '0' + add1 * a) % 10;
                    }
                }
                current[n] = '\0';
                if (strcmp(current, result) < 0) {
                    strcpy(result, current);
                }
            }
        }

        start = (start + b) % n;
    }

    free(current);
    return result;
}