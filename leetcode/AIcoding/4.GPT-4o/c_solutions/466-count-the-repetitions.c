int getMaxRepetitions(char *s1, int n1, char *s2, int n2) {
    int len1 = strlen(s1), len2 = strlen(s2);
    int count = 0, j = 0;
    int *repeats = (int *)malloc((len2 + 1) * sizeof(int));
    int *indexes = (int *)malloc((len2 + 1) * sizeof(int));

    for (int i = 0; i <= len2; i++) {
        repeats[i] = 0;
        indexes[i] = -1;
    }

    for (int i = 0; i < n1; i++) {
        for (int k = 0; k < len1; k++) {
            if (s1[k] == s2[j]) {
                j++;
                if (j == len2) {
                    count++;
                    j = 0;
                }
            }
        }
        repeats[i + 1] = count;
        indexes[i + 1] = j;
    }

    for (int i = 0; i < n1; i++) {
        for (int k = i + 1; k <= n1; k++) {
            if (indexes[i] == indexes[k]) {
                int repeated = (repeats[k] - repeats[i]) * (n1 - k) / (k - i);
                count += repeated;
                n1 = k;
                break;
            }
        }
    }

    free(repeats);
    free(indexes);
    return count / n2;
}