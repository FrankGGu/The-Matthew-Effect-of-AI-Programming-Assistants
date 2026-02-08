int* shortestToChar(char* s, char c, int* returnSize) {
    int n = strlen(s);
    int* distances = (int*)malloc(n * sizeof(int));
    int lastC = -1;

    for (int i = 0; i < n; i++) {
        if (s[i] == c) {
            lastC = i;
        }
        distances[i] = lastC == -1 ? n : i - lastC;
    }

    lastC = -1;
    for (int i = n - 1; i >= 0; i--) {
        if (s[i] == c) {
            lastC = i;
        }
        if (lastC != -1) {
            distances[i] = fmin(distances[i], lastC - i);
        }
    }

    *returnSize = n;
    return distances;
}