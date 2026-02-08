#define MAX(a, b) ((a) > (b) ? (a) : (b))

int dfs(int node, int parent, int* values, int** edges, int edgesSize, int* edgesColSize, long long* score) {
    long long total = values[node];
    for (int i = 0; i < edgesSize; i++) {
        if (edges[i][0] == node && edges[i][1] != parent) {
            total += dfs(edges[i][1], node, values, edges, edgesSize, edgesColSize, score);
        } else if (edges[i][1] == node && edges[i][0] != parent) {
            total += dfs(edges[i][0], node, values, edges, edgesSize, edgesColSize, score);
        }
    }
    *score = MAX(*score, total);
    return total;
}

long long maxScore(int* values, int valuesSize, int** edges, int edgesSize, int* edgesColSize) {
    long long score = 0;
    dfs(0, -1, values, edges, edgesSize, edgesColSize, &score);
    return score;
}