class TreeAncestor {
public:
    vector<vector<int>> up;
    int LOG;

    TreeAncestor(int n, vector<int>& parent) {
        LOG = 0;
        while ((1 << LOG) <= n) {
            LOG++;
        }
        up = vector<vector<int>>(n, vector<int>(LOG, -1));
        for (int v = 0; v < n; v++) {
            up[v][0] = parent[v];
        }
        for (int j = 1; j < LOG; j++) {
            for (int v = 0; v < n; v++) {
                if (up[v][j - 1] != -1) {
                    up[v][j] = up[up[v][j - 1]][j - 1];
                }
            }
        }
    }

    int getKthAncestor(int node, int k) {
        for (int j = 0; j < LOG; j++) {
            if (k & (1 << j)) {
                node = up[node][j];
                if (node == -1) return -1;
            }
        }
        return node;
    }
};