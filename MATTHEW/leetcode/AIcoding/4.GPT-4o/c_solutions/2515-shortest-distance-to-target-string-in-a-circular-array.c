int closetTarget(char **words, int wordsSize, char *target, int startIndex) {
    int minDistance = INT_MAX;
    for (int i = 0; i < wordsSize; i++) {
        if (strcmp(words[(startIndex + i) % wordsSize], target) == 0) {
            minDistance = fmin(minDistance, i);
        }
        if (strcmp(words[(startIndex - i + wordsSize) % wordsSize], target) == 0) {
            minDistance = fmin(minDistance, i);
        }
    }
    return minDistance == INT_MAX ? -1 : minDistance;
}