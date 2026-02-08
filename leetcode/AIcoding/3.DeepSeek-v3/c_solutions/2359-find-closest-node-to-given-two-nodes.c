int closestMeetingNode(int* edges, int edgesSize, int node1, int node2) {
    int* dist1 = (int*)malloc(edgesSize * sizeof(int));
    int* dist2 = (int*)malloc(edgesSize * sizeof(int));

    for (int i = 0; i < edgesSize; i++) {
        dist1[i] = -1;
        dist2[i] = -1;
    }

    dist1[node1] = 0;
    dist2[node2] = 0;

    int cur = node1;
    int d = 0;
    while (edges[cur] != -1 && dist1[edges[cur]] == -1) {
        d++;
        dist1[edges[cur]] = d;
        cur = edges[cur];
    }

    cur = node2;
    d = 0;
    while (edges[cur] != -1 && dist2[edges[cur]] == -1) {
        d++;
        dist2[edges[cur]] = d;
        cur = edges[cur];
    }

    int minDist = INT_MAX;
    int result = -1;

    for (int i = 0; i < edgesSize; i++) {
        if (dist1[i] != -1 && dist2[i] != -1) {
            int maxDist = dist1[i] > dist2[i] ? dist1[i] : dist2[i];
            if (maxDist < minDist) {
                minDist = maxDist;
                result = i;
            } else if (maxDist == minDist && i < result) {
                result = i;
            }
        }
    }

    free(dist1);
    free(dist2);

    return result;
}