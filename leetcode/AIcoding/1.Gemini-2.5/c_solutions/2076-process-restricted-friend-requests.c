#include <stdbool.h>
#include <stdlib.h>

static int* parent;
static int* sz;

static int find(int i) {
    if (parent[i] == i)
        return i;
    return parent[i] = find(parent[i]);
}

static void unite(int i, int j) {
    int root_i = find(i);
    int root_j = find(j);
    if (root_i != root_j) {
        if (sz[root_i] < sz[root_j]) {
            int temp = root_i;
            root_i = root_j;
            root_j = temp;
        }
        parent[root_j] = root_i;
        sz[root_i] += sz[root_j];
    }
}

static void init_dsu(int n) {
    parent = (int*)malloc(n * sizeof(int));
    sz = (int*)malloc(n * sizeof(int));
    for (int i = 0; i < n; ++i) {
        parent[i] = i;
        sz[i] = 1;
    }
}

bool* canRequest(int n, int** restrictions, int restrictionsSize, int* restrictionsColSize, int** requests, int requestsSize, int* requestsColSize) {
    bool* ans = (bool*)malloc(requestsSize * sizeof(bool));

    init_dsu(n);

    for (int i = 0; i < requestsSize; ++i) {
        int p1 = requests[i][0];
        int p2 = requests[i][1];

        bool possible = true;
        for (int j = 0; j < restrictionsSize; ++j) {
            int x = restrictions[j][0];
            int y = restrictions[j][1];

            int root_p1 = find(p1);
            int root_p2 = find(p2);
            int root_x = find(x);
            int root_y = find(y);

            if ((root_p1 == root_x && root_p2 == root_y) || (root_p1 == root_y && root_p2 == root_x)) {
                possible = false;
                break;
            }
        }

        ans[i] = possible;
        if (possible) {
            unite(p1, p2);
        }
    }

    free(parent);
    free(sz);

    return ans;
}