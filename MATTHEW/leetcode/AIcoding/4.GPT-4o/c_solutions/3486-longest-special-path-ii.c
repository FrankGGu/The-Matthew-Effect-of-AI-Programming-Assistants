#define MAX(a, b) ((a) > (b) ? (a) : (b))

int longestPath(int** parent, int parentSize, int* parentColSize) {
    int n = parentSize;
    int* longest = (int*)malloc(n * sizeof(int));
    int maxLength = 0;

    for (int i = n - 1; i >= 0; i--) {
        longest[i] = 1; // Every node is at least a path of length 1
        for (int j = 0; j < parentColSize[i]; j++) {
            int child = parent[i][j];
            if (child != -1) {
                longest[i] = MAX(longest[i], 1 + longest[child]);
            }
        }
        maxLength = MAX(maxLength, longest[i]);
    }

    free(longest);
    return maxLength;
}