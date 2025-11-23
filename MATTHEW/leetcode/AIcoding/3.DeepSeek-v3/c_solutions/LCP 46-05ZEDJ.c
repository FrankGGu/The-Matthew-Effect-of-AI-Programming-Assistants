int* volunteerDeployment(int* finalState, int finalStateSize, int** edges, int edgesSize, int* edgesColSize, long long time, int* returnSize) {
    int n = finalStateSize;
    int m = edgesSize;

    int* degree = (int*)calloc(n, sizeof(int));
    int** graph = (int**)malloc(n * sizeof(int*));
    for (int i = 0; i < n; i++) {
        graph[i] = (int*)malloc(n * sizeof(int));
        for (int j = 0; j < n; j++) {
            graph[i][j] = 0;
        }
    }

    for (int i = 0; i < m; i++) {
        int u = edges[i][0];
        int v = edges[i][1];
        graph[u][v] = 1;
        graph[v][u] = 1;
        degree[u]++;
        degree[v]++;
    }

    double** matrix = (double**)malloc(n * sizeof(double*));
    for (int i = 0; i < n; i++) {
        matrix[i] = (double*)malloc((n + 1) * sizeof(double));
        for (int j = 0; j <= n; j++) {
            matrix[i][j] = 0.0;
        }
    }

    for (int i = 0; i < n; i++) {
        matrix[i][i] = 1.0;
        if (finalState[i] != -1) {
            matrix[i][n] = finalState[i];
        } else {
            matrix[i][n] = 0.0;
            matrix[i][i] -= 1.0;
            for (int j = 0; j < n; j++) {
                if (graph[i][j]) {
                    matrix[i][j] += 1.0 / degree[j];
                }
            }
        }
    }

    for (int i = 0; i < n; i++) {
        if (finalState[i] != -1) {
            for (int j = 0; j < n; j++) {
                if (graph[i][j] && finalState[j] == -1) {
                    matrix[j][n] -= matrix[j][i] * finalState[i];
                    matrix[j][i] = 0.0;
                }
            }
        }
    }

    int* res = (int*)malloc(n * sizeof(int));
    *returnSize = n;

    for (int i = 0; i < n; i++) {
        if (finalState[i] != -1) {
            res[i] = finalState[i];
        } else {
            double val = matrix[i][n];
            for (int j = 0; j < n; j++) {
                if (j != i && graph[i][j] && finalState[j] != -1) {
                    val -= matrix[i][j] * finalState[j];
                }
            }
            res[i] = (int)(val + 0.5);
        }
    }

    free(degree);
    for (int i = 0; i < n; i++) {
        free(graph[i]);
    }
    free(graph);
    for (int i = 0; i < n; i++) {
        free(matrix[i]);
    }
    free(matrix);

    return res;
}