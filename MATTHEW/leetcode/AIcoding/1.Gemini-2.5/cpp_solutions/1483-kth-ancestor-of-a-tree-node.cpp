#include <vector>

class TreeAncestor {
public:
    static const int MAX_LOG = 17; // For N up to 5*10^4, log2(50000) approx 15.6, so 16 levels are needed. Using 17 for safety.
    std::vector<std::vector<int>> up;

    TreeAncestor(int n, std::vector<int>& parent) {
        up.assign(MAX_LOG, std::vector<int>(n));

        for (int i = 0; i < n; ++i) {
            up[0][i] = parent[i];
        }

        for (int k = 1; k < MAX_LOG; ++k) {
            for (int i = 0; i < n; ++i) {
                if (up[k-1][i] == -1) {
                    up[k][i] = -1;
                } else {
                    up[k][i] = up[k-1][up[k-1][i]];
                }
            }
        }
    }

    int getKthAncestor(int node, int k) {
        for (int i = MAX_LOG - 1; i >= 0; --i) {
            if (node == -1) {
                break;
            }
            if ((k >> i) & 1) {
                node = up[i][node];
            }
        }
        return node;
    }
};