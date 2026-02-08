int repeatedStringMatch(char * A, char * B) {
    int lenA = strlen(A);
    int lenB = strlen(B);
    int repeatCount = (lenB + lenA - 1) / lenA; // Minimum times A needs to repeat

    for (int i = 0; i <= 1; i++) {
        char *repeatedA = (char *)malloc((repeatCount + i) * lenA + 1);
        for (int j = 0; j < repeatCount + i; j++) {
            strcpy(repeatedA + j * lenA, A);
        }
        if (strstr(repeatedA, B) != NULL) {
            free(repeatedA);
            return repeatCount + i;
        }
        free(repeatedA);
    }
    return -1;
}