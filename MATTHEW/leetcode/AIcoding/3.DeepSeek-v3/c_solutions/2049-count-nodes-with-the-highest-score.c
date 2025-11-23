/**
 * Note: The returned array must be malloced, assume caller calls free().
 */
int countHighestScoreNodes(int* parents, int parentsSize) {
    int n = parentsSize;
    int* left = (int*)malloc(n * sizeof(int));
    int* right = (int*)malloc(n * sizeof(int));
    for (int i = 0; i < n; i++) {
        left[i] = -1;
        right[i] = -1;
    }

    for (int i = 1; i < n; i++) {
        int p = parents[i];
        if (left[p] == -1) {
            left[p] = i;
        } else {
            right[p] = i;
        }
    }

    int* size = (int*)malloc(n * sizeof(int));

    long long maxScore = 0;
    int count = 0;

    void dfs(int node) {
        size[node] = 1;
        long long product = 1;
        int remaining = n - 1;

        if (left[node] != -1) {
            dfs(left[node]);
            product *= size[left[node]];
            remaining -= size[left[node]];
        }
        if (right[node] != -1) {
            dfs(right[node]);
            product *= size[right[node]];
            remaining -= size[right[node]];
        }
        if (remaining > 0) {
            product *= remaining;
        }

        size[node] = n - remaining;

        if (product > maxScore) {
            maxScore = product;
            count = 1;
        } else if (product == maxScore) {
            count++;
        }
    }

    dfs(0);

    free(left);
    free(right);
    free(size);

    return count;
}