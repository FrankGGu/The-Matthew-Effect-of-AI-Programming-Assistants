int longestCycle(int* edges, int edgesSize) {
    int* visited = (int*)calloc(edgesSize, sizeof(int));
    int maxLength = -1;

    for (int i = 0; i < edgesSize; i++) {
        if (visited[i] == 0) {
            int currentLength = 0;
            int* stack = (int*)malloc(edgesSize * sizeof(int));
            int top = 0;
            int* indices = (int*)calloc(edgesSize, sizeof(int));
            int index = 0;
            int cycleStart = -1;

            for (int j = i; j != -1; j = edges[j]) {
                if (visited[j] == 1) {
                    cycleStart = j;
                    break;
                }
                if (visited[j] == 2) break;

                visited[j] = 1;
                stack[top++] = j;
                indices[j] = index++;
            }

            if (cycleStart != -1) {
                int cycleLength = index - indices[cycleStart];
                maxLength = maxLength > cycleLength ? maxLength : cycleLength;
            }

            for (int j = 0; j < top; j++) {
                visited[stack[j]] = 2;
            }

            free(stack);
            free(indices);
        }
    }

    free(visited);
    return maxLength;
}