char * pushDominoes(char * dominoes) {
    int n = strlen(dominoes);
    char *result = (char *)malloc((n + 1) * sizeof(char));
    strcpy(result, dominoes);
    int left = -1, right = -1;

    for (int i = 0; i < n; i++) {
        if (result[i] == 'L') {
            if (right != -1 && right < i) {
                for (int j = right + 1; j < i; j++) {
                    result[j] = 'R';
                }
            }
            left = i;
        } else if (result[i] == 'R') {
            if (left != -1 && left > right) {
                for (int j = left + 1; j < i; j++) {
                    result[j] = 'L';
                }
            }
            right = i;
        }
    }

    if (right != -1) {
        for (int j = right + 1; j < n; j++) {
            result[j] = 'R';
        }
    }

    if (left != -1) {
        for (int j = 0; j < left; j++) {
            result[j] = 'L';
        }
    }

    return result;
}