#include <vector>
#include <cmath>
#include <numeric>

class DSU {
public:
    std::vector<int> parent;
    DSU(int n) {
        parent.resize(n);
        std::iota(parent.begin(), parent.end(), 0);
    }

    int find(int i) {
        if (parent[i] == i)
            return i;
        return parent[i] = find(parent[i]);
    }

    void unite(int i, int j) {
        int root_i = find(i);
        int root_j = find(j);
        if (root_i != root_j) {
            parent[root_i] = root_j;
        }
    }
};

class Solution {
public:
    bool checkDist(long long x1, long long y1, long long r1, long long x2, long long y2, long long r2) {
        long long dx = x1 - x2;
        long long dy = y1 - y2;
        long long r_sum = r1 + r2;
        return dx * dx + dy * dy <= r_sum * r_sum;
    }

    bool canReachCorner(long long rx1, long long ry1, long long rx2, long long ry2, std::vector<std::vector<int>>& circles) {
        int n = circles.size();
        DSU dsu(n + 4); // N circles + 4 virtual nodes for boundaries (L, R, B, T)

        // Virtual nodes:
        // n: Left boundary (x = rx1)
        // n+1: Right boundary (x = rx2)
        // n+2: Bottom boundary (y = ry1)
        // n+3: Top boundary (y = ry2)

        for (int i = 0; i < n; ++i) {
            long long cx_i = circles[i][0];
            long long cy_i = circles[i][1];
            long long r_i = circles[i][2];

            // Check connection to boundaries
            if (cx_i - r_i <= rx1) { // Touches or crosses left boundary
                dsu.unite(i, n);
            }
            if (cx_i + r_i >= rx2) { // Touches or crosses right boundary
                dsu.unite(i, n + 1);
            }
            if (cy_i - r_i <= ry1) { // Touches or crosses bottom boundary
                dsu.unite(i, n + 2);
            }
            if (cy_i + r_i >= ry2) { // Touches or crosses top boundary
                dsu.unite(i, n + 3);
            }

            // Check connection between circles
            for (int j = i + 1; j < n; ++j) {
                long long cx_j = circles[j][0];
                long long cy_j = circles[j][1];
                long long r_j = circles[j][2];
                if (checkDist(cx_i, cy_i, r_i, cx_j, cy_j, r_j)) {
                    dsu.unite(i, j);
                }
            }
        }

        // Check if the path is blocked
        // L = n, R = n+1, B = n+2, T = n+3
        int root_L = dsu.find(n);
        int root_R = dsu.find(n + 1);
        int root_B = dsu.find(n + 2);
        int root_T = dsu.find(n + 3);

        // Path is blocked if any of these conditions are met:
        // 1. A chain of circles connects left and right boundaries (horizontal cut).
        // 2. A chain of circles connects bottom and top boundaries (vertical cut).
        // 3. A chain of circles connects left and top boundaries AND right and bottom boundaries (diagonal cut).
        //    This means the top-left region is blocked AND the bottom-right region is blocked.

        bool blocked = false;
        if (root_L == root_R) {
            blocked = true;
        }
        if (root_B == root_T) {
            blocked = true;
        }
        if (root_L == root_T && root_R == root_B) {
            blocked = true;
        }

        return !blocked;
    }
};