/**
 * Note: The returned array must be malloced, assume caller calls free().
 */
int gcd(int a, int b) {
    while (b != 0) {
        int temp = b;
        b = a % b;
        a = temp;
    }
    return a;
}

void dfs(int node, int parent, int depth, int* nums, int** graph, int* graphSize, int** result, int* path, int* pathDepth, int** ancestors) {
    int maxDepth = -1;
    int candidate = -1;

    for (int i = 1; i <= 50; i++) {
        if (ancestors[i][0] != -1 && gcd(nums[node], i) == 1) {
            if (ancestors[i][1] > maxDepth) {
                maxDepth = ancestors[i][1];
                candidate = ancestors[i][0];
            }
        }
    }

    result[node][0] = candidate;

    int tempVal = nums[node];
    int tempDepth = ancestors[tempVal][1];
    int tempNode = ancestors[tempVal][0];

    ancestors[tempVal][0] = node;
    ancestors[tempVal][1] = depth;

    for (int i = 0; i < graphSize[node]; i++) {
        int neighbor = graph[node][i];
        if (neighbor != parent) {
            dfs(neighbor, node, depth + 1, nums, graph, graphSize, result, path, pathDepth, ancestors);
        }
    }

    ancestors[tempVal][0] = tempNode;
    ancestors[tempVal][1] = tempDepth;
}

int* getCoprimes(int* nums, int numsSize, int** edges, int edgesSize, int* edgesColSize, int* returnSize) {
    *returnSize = numsSize;
    int** graph = (int**)malloc(numsSize * sizeof(int*));
    int* graphSize = (int*)calloc(numsSize, sizeof(int));

    for (int i = 0; i < numsSize; i++) {
        graph[i] = (int*)malloc(100 * sizeof(int));
    }

    for (int i = 0; i < edgesSize; i++) {
        int u = edges[i][0];
        int v = edges[i][1];
        graph[u][graphSize[u]++] = v;
        graph[v][graphSize[v]++] = u;
    }

    int** result = (int**)malloc(numsSize * sizeof(int*));
    for (int i = 0; i < numsSize; i++) {
        result[i] = (int*)malloc(sizeof(int));
    }

    int* path = (int*)malloc(numsSize * sizeof(int));
    int pathDepth = 0;

    int** ancestors = (int**)malloc(51 * sizeof(int*));
    for (int i = 0; i <= 50; i++) {
        ancestors[i] = (int*)malloc(2 * sizeof(int));
        ancestors[i][0] = -1;
        ancestors[i][1] = -1;
    }

    dfs(0, -1, 0, nums, graph, graphSize, result, path, &pathDepth, ancestors);

    int* ans = (int*)malloc(numsSize * sizeof(int));
    for (int i = 0; i < numsSize; i++) {
        ans[i] = result[i][0];
    }

    for (int i = 0; i < numsSize; i++) {
        free(graph[i]);
        free(result[i]);
    }
    free(graph);
    free(graphSize);
    free(result);
    free(path);
    for (int i = 0; i <= 50; i++) {
        free(ancestors[i]);
    }
    free(ancestors);

    return ans;
}