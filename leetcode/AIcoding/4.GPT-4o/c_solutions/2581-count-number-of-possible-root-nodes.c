int countRootNodes(int* parent, int parentSize) {
    int count = 0;
    int* degree = (int*)calloc(parentSize, sizeof(int));

    for (int i = 0; i < parentSize; i++) {
        if (parent[i] != -1) {
            degree[parent[i]]++;
        }
    }

    for (int i = 0; i < parentSize; i++) {
        if (degree[i] == 0) {
            count++;
        }
    }

    free(degree);
    return count;
}