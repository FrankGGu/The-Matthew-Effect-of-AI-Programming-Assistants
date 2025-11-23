#include <stdio.h>
#include <stdlib.h>
#include <string.h>

double maxProbability(int n, int** edges, int edgesSize, int* edgesColSize, int start_node, int end_node) {
    double* prob = (double*)malloc(n * sizeof(double));
    for (int i = 0; i < n; i++) {
        prob[i] = 0.0;
    }
    prob[start_node] = 1.0;

    bool updated = true;
    while (updated) {
        updated = false;
        for (int i = 0; i < edgesSize; i++) {
            int u = edges[i][0];
            int v = edges[i][1];
            double p = (double)edges[i][2] / 100000.0; 

            if (prob[u] * p > prob[v]) {
                prob[v] = prob[u] * p;
                updated = true;
            }
            if (prob[v] * p > prob[u]) {
                prob[u] = prob[v] * p;
                updated = true;
            }
        }
    }

    double result = prob[end_node];
    free(prob);
    return result;
}