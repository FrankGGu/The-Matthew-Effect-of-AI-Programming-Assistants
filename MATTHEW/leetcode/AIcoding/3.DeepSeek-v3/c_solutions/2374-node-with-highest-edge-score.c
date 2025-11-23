int edgeScore(int* edges, int edgesSize) {
    long long *scores = (long long *)calloc(edgesSize, sizeof(long long));

    for (int i = 0; i < edgesSize; i++) {
        scores[edges[i]] += i;
    }

    int maxNode = 0;
    for (int i = 1; i < edgesSize; i++) {
        if (scores[i] > scores[maxNode]) {
            maxNode = i;
        }
    }

    free(scores);
    return maxNode;
}