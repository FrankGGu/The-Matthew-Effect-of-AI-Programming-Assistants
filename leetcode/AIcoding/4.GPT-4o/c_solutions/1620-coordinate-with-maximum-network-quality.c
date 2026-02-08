int maximumNetworkQuality(int** nodes, int nodesSize, int* nodesColSize, int k) {
    int maxQuality = 0;
    for (int i = 0; i < nodesSize; i++) {
        for (int j = 0; j < nodesSize; j++) {
            if (i != j) {
                int quality = nodes[i][2] + nodes[j][2];
                if (quality > maxQuality) {
                    maxQuality = quality;
                }
            }
        }
    }
    return maxQuality;
}