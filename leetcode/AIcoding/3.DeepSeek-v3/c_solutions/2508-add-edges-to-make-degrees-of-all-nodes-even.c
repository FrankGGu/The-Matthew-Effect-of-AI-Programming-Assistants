/**
 * Note: The returned array must be malloced, assume caller calls free().
 */
int* addEdges(int n, int** edges, int edgesSize, int* edgesColSize, int* returnSize) {
    int* degree = (int*)calloc(n + 1, sizeof(int));
    for (int i = 0; i < edgesSize; i++) {
        degree[edges[i][0]]++;
        degree[edges[i][1]]++;
    }

    int* oddNodes = (int*)malloc(n * sizeof(int));
    int oddCount = 0;
    for (int i = 1; i <= n; i++) {
        if (degree[i] % 2 == 1) {
            oddNodes[oddCount++] = i;
        }
    }

    int* result = (int*)malloc(4 * sizeof(int));
    *returnSize = 0;

    if (oddCount == 0) {
        *returnSize = 0;
        free(degree);
        free(oddNodes);
        return result;
    }

    if (oddCount == 2) {
        int u = oddNodes[0];
        int v = oddNodes[1];

        int found = 0;
        for (int i = 0; i < edgesSize; i++) {
            int a = edges[i][0], b = edges[i][1];
            if ((a == u && b == v) || (a == v && b == u)) {
                found = 1;
                break;
            }
        }

        if (!found) {
            result[0] = u;
            result[1] = v;
            *returnSize = 2;
        } else {
            for (int i = 1; i <= n; i++) {
                if (i != u && i != v) {
                    int found1 = 0, found2 = 0;
                    for (int j = 0; j < edgesSize; j++) {
                        int a = edges[j][0], b = edges[j][1];
                        if ((a == u && b == i) || (a == i && b == u)) found1 = 1;
                        if ((a == v && b == i) || (a == i && b == v)) found2 = 1;
                    }
                    if (!found1 && !found2) {
                        result[0] = u;
                        result[1] = i;
                        result[2] = v;
                        result[3] = i;
                        *returnSize = 4;
                        break;
                    }
                }
            }
        }
    } else if (oddCount == 4) {
        int a = oddNodes[0], b = oddNodes[1], c = oddNodes[2], d = oddNodes[3];

        int ab = 0, ac = 0, ad = 0, bc = 0, bd = 0, cd = 0;
        for (int i = 0; i < edgesSize; i++) {
            int u = edges[i][0], v = edges[i][1];
            if ((u == a && v == b) || (u == b && v == a)) ab = 1;
            if ((u == a && v == c) || (u == c && v == a)) ac = 1;
            if ((u == a && v == d) || (u == d && v == a)) ad = 1;
            if ((u == b && v == c) || (u == c && v == b)) bc = 1;
            if ((u == b && v == d) || (u == d && v == b)) bd = 1;
            if ((u == c && v == d) || (u == d && v == c)) cd = 1;
        }

        if (!ab && !cd) {
            result[0] = a;
            result[1] = b;
            result[2] = c;
            result[3] = d;
            *returnSize = 4;
        } else if (!ac && !bd) {
            result[0] = a;
            result[1] = c;
            result[2] = b;
            result[3] = d;
            *returnSize = 4;
        } else if (!ad && !bc) {
            result[0] = a;
            result[1] = d;
            result[2] = b;
            result[3] = c;
            *returnSize = 4;
        }
    }

    free(degree);
    free(oddNodes);
    return result;
}