int compare(const void* a, const void* b) {
    return *(char*)a - *(char*)b;
}

bool checkIfCanBreak(char* s1, char* s2) {
    int n = strlen(s1);

    char* sorted1 = malloc(n + 1);
    char* sorted2 = malloc(n + 1);

    strcpy(sorted1, s1);
    strcpy(sorted2, s2);

    qsort(sorted1, n, sizeof(char), compare);
    qsort(sorted2, n, sizeof(char), compare);

    bool canBreak1 = true;
    bool canBreak2 = true;

    for (int i = 0; i < n; i++) {
        if (sorted1[i] < sorted2[i]) {
            canBreak1 = false;
        }
        if (sorted2[i] < sorted1[i]) {
            canBreak2 = false;
        }
        if (!canBreak1 && !canBreak2) {
            break;
        }
    }

    free(sorted1);
    free(sorted2);

    return canBreak1 || canBreak2;
}