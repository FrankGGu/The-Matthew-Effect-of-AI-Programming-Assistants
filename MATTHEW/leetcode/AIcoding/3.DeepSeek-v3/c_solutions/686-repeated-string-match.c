int repeatedStringMatch(char* a, char* b) {
    int lenA = strlen(a);
    int lenB = strlen(b);

    int maxRepeat = (lenB / lenA) + 2;
    char* repeated = (char*)malloc((lenA * maxRepeat + 1) * sizeof(char));

    strcpy(repeated, a);
    int count = 1;

    while (strlen(repeated) < lenB) {
        strcat(repeated, a);
        count++;
    }

    if (strstr(repeated, b) != NULL) {
        free(repeated);
        return count;
    }

    strcat(repeated, a);
    count++;

    if (strstr(repeated, b) != NULL) {
        free(repeated);
        return count;
    }

    free(repeated);
    return -1;
}