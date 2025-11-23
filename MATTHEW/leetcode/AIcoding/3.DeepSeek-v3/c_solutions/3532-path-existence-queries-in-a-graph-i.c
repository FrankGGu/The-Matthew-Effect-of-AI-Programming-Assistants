/**
 * Note: The returned array must be malloced, assume caller calls free().
 */
bool* friendRequests(int n, int** restrictions, int restrictionsSize, int* restrictionsColSize, int** requests, int requestsSize, int* requestsColSize, int* returnSize) {
    int* parent = (int*)malloc(n * sizeof(int));
    for (int i = 0; i < n; i++) {
        parent[i] = i;
    }

    bool* result = (bool*)malloc(requestsSize * sizeof(bool));
    *returnSize = requestsSize;

    for (int i = 0; i < requestsSize; i++) {
        int u = requests[i][0];
        int v = requests[i][1];

        int root_u = u;
        while (parent[root_u] != root_u) {
            root_u = parent[root_u];
        }

        int root_v = v;
        while (parent[root_v] != root_v) {
            root_v = parent[root_v];
        }

        if (root_u == root_v) {
            result[i] = true;
            continue;
        }

        bool valid = true;
        for (int j = 0; j < restrictionsSize; j++) {
            int x = restrictions[j][0];
            int y = restrictions[j][1];

            int root_x = x;
            while (parent[root_x] != root_x) {
                root_x = parent[root_x];
            }

            int root_y = y;
            while (parent[root_y] != root_y) {
                root_y = parent[root_y];
            }

            if ((root_x == root_u && root_y == root_v) || (root_x == root_v && root_y == root_u)) {
                valid = false;
                break;
            }
        }

        if (valid) {
            parent[root_v] = root_u;
            result[i] = true;
        } else {
            result[i] = false;
        }
    }

    free(parent);
    return result;
}