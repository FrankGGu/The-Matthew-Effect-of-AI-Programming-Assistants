bool canStamp(char* stamp, char* target) {
    int n = strlen(target), m = strlen(stamp);
    bool changed = true;
    bool visited[n];
    memset(visited, 0, sizeof(visited));

    while (changed) {
        changed = false;
        for (int i = 0; i <= n - m; i++) {
            if (!visited[i] && strncmp(target + i, stamp, m) != 0) {
                bool canReplace = true;
                for (int j = 0; j < m; j++) {
                    if (target[i + j] != '?' && target[i + j] != stamp[j]) {
                        canReplace = false;
                        break;
                    }
                }
                if (canReplace) {
                    changed = true;
                    for (int j = 0; j < m; j++) {
                        target[i + j] = '?';
                    }
                    visited[i] = true;
                }
            }
        }
    }

    for (int i = 0; i < n; i++) {
        if (target[i] != '?') return false;
    }
    return true;
}

bool* movesToStamp(char* stamp, char* target, int* returnSize) {
    int n = strlen(target), m = strlen(stamp);
    bool* result = (bool*)malloc(n * sizeof(bool));
    *returnSize = 0;

    while (1) {
        bool madeMove = false;
        for (int i = 0; i <= n - m; i++) {
            if (strncmp(target + i, stamp, m) != 0) {
                bool canStamp = true;
                for (int j = 0; j < m; j++) {
                    if (target[i + j] != '?' && target[i + j] != stamp[j]) {
                        canStamp = false;
                        break;
                    }
                }
                if (canStamp) {
                    madeMove = true;
                    for (int j = 0; j < m; j++) {
                        target[i + j] = '?';
                    }
                    result[(*returnSize)++] = true;
                }
            }
        }
        if (!madeMove) break;
    }

    for (int i = 0; i < n; i++) {
        if (target[i] != '?') {
            *returnSize = 0;
            return result;
        }
    }

    return result;
}