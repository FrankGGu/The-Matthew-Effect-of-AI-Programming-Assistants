#include <limits.h>
#include <stdlib.h>

#define NEG_INF (LLONG_MIN / 2)

typedef struct {
    int rows;
    int cols;
    long long **data;
} Matrix;

Matrix* createMatrix(int r, int c) {
    Matrix* mat = (Matrix*)malloc(sizeof(Matrix));
    mat->rows = r;
    mat->cols = c;
    mat->data = (long long**)malloc(r * sizeof(long long*));
    for (int i = 0; i < r; i++) {
        mat->data[i] = (long long*)malloc(c * sizeof(long long));
    }
    return mat;
}

void freeMatrix(Matrix* mat) {
    if (mat == NULL) return;
    for (int i = 0; i < mat->rows; i++) {
        free(mat->data[i]);
    }
    free(mat->data);
    free(mat);
}

Matrix* multiply(Matrix* A, Matrix* B) {
    int n = A->rows; // Assuming square matrices of size n x n
    Matrix* C = createMatrix(n, n);

    for (int i = 0; i < n; i++) {
        for (int j = 0; j < n; j++) {
            C->data[i][j] = NEG_INF; // Initialize with negative infinity
            for (int k = 0; k < n; k++) {
                // Only consider paths if both segments (A[i][k] and B[k][j]) are valid
                if (A->data[i][k] != NEG_INF && B->data[k][j] != NEG_INF) {
                    long long current_sum = A->data[i][k] + B->data[k][j];
                    if (current_sum > C->data[i][j]) {
                        C->data[i][j] = current_sum;
                    }
                }
            }
        }
    }
    return C;
}

Matrix* matrixPower(Matrix* A, long long k) {
    int n = A->rows;
    Matrix* res = createMatrix(n, n);

    // Initialize res as an identity matrix for max-plus algebra:
    // res[i][i] = 0 (a path of length 0 has weight 0)
    // res[i][j] = NEG_INF for i != j (no path of length 0 between different nodes)
    for (int i = 0; i < n; i++) {
        for (int j = 0; j < n; j++) {
            res->data[i][j] = (i == j) ? 0 : NEG_INF;
        }
    }

    // Create a copy of A to avoid modifying the original
    Matrix* current_A = createMatrix(n, n);
    for (int i = 0; i < n; i++) {
        for (int j = 0; j < n; j++) {
            current_A->data[i][j] = A->data[i][j];
        }
    }

    while (k > 0) {
        if (k % 2 == 1) { // If k is odd, multiply res by current_A
            Matrix* temp = multiply(res, current_A);
            freeMatrix(res);
            res = temp;
        }
        // Square current_A
        Matrix* temp = multiply(current_A, current_A);
        freeMatrix(current_A);
        current_A = temp;
        k /= 2;
    }

    freeMatrix(current_A); // Free the last current_A
    return res;
}

long long maxWeightedKEdgePath(int n, int** edges, int edgesSize, int* edgesColSize, int k) {
    if (n == 0) return -1; // Handle empty graph case

    Matrix* adj = createMatrix(n, n);

    // Initialize adjacency matrix with NEG_INF (no direct path)
    for (int i = 0; i < n; i++) {
        for (int j = 0; j < n; j++) {
            adj->data[i][j] = NEG_INF;
        }
    }

    // Populate adjacency matrix with given edges.
    // If multiple edges exist between u and v, take the one with maximum weight.
    for (int i = 0; i < edgesSize; i++) {
        int u = edges[i][0];
        int v = edges[i][1];
        int weight = edges[i][2];
        if (weight > adj->data[u][v]) {
            adj->data[u][v] = weight;
        }
    }

    // Compute the matrix representing all paths of length k
    Matrix* result_matrix = matrixPower(adj, k);

    long long max_weight = NEG_INF;
    // Find the maximum weight among all possible paths of length k
    for (int i = 0; i < n; i++) {
        for (int j = 0; j < n; j++) {
            if (result_matrix->data[i][j] > max_weight) {
                max_weight = result_matrix->data[i][j];
            }
        }
    }

    freeMatrix(adj);
    freeMatrix(result_matrix);

    // If max_weight is still NEG_INF, it means no path of length k exists.
    // Return -1 as per common LeetCode practice for "no solution".
    return (max_weight == NEG_INF) ? -1 : max_weight;
}