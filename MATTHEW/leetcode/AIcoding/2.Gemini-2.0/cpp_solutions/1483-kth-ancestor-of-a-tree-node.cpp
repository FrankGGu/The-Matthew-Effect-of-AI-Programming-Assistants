#include <vector>

using namespace std;

class TreeAncestor {
public:
    vector<vector<int>> up;
    int log_n;

    TreeAncestor(int n, vector<int>& parent) {
        log_n = 0;
        while ((1 << log_n) <= n) {
            log_n++;
        }

        up.assign(n, vector<int>(log_n, -1));

        for (int i = 0; i < n; ++i) {
            up[i][0] = parent[i];
        }

        for (int j = 1; j < log_n; ++j) {
            for (int i = 0; i < n; ++i) {
                if (up[i][j - 1] != -1) {
                    up[i][j] = up[up[i][j - 1]][j - 1];
                }
            }
        }
    }

    int getKthAncestor(int node, int k) {
        for (int j = 0; j < log_n; ++j) {
            if ((k >> j) & 1) {
                node = up[node][j];
                if (node == -1) {
                    return -1;
                }
            }
        }
        return node;
    }
};