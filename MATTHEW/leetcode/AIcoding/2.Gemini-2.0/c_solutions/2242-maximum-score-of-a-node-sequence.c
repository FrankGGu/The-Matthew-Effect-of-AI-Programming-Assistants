#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int max(int a, int b) {
    return (a > b) ? a : b;
}

int maxScore(int* scores, int scoresSize, int** edges, int edgesSize, int* edgesColSize) {
    int max_score = -1;
    for (int i = 0; i < scoresSize; i++) {
        for (int j = i + 1; j < scoresSize; j++) {
            for (int k = j + 1; k < scoresSize; k++) {
                for (int l = k + 1; l < scoresSize; l++) {
                    int edge_ij = 0, edge_ik = 0, edge_il = 0, edge_jk = 0, edge_jl = 0, edge_kl = 0;
                    for (int m = 0; m < edgesSize; m++) {
                        if ((edges[m][0] == i && edges[m][1] == j) || (edges[m][0] == j && edges[m][1] == i)) edge_ij = 1;
                        if ((edges[m][0] == i && edges[m][1] == k) || (edges[m][0] == k && edges[m][1] == i)) edge_ik = 1;
                        if ((edges[m][0] == i && edges[m][1] == l) || (edges[m][0] == l && edges[m][1] == i)) edge_il = 1;
                        if ((edges[m][0] == j && edges[m][1] == k) || (edges[m][0] == k && edges[m][1] == j)) edge_jk = 1;
                        if ((edges[m][0] == j && edges[m][1] == l) || (edges[m][0] == l && edges[m][1] == j)) edge_jl = 1;
                        if ((edges[m][0] == k && edges[m][1] == l) || (edges[m][0] == l && edges[m][1] == k)) edge_kl = 1;
                    }
                    if (edge_ij && edge_ik && edge_il && edge_jk && edge_jl && edge_kl) {
                        max_score = max(max_score, scores[i] + scores[j] + scores[k] + scores[l]);
                    }
                }
            }
        }
    }
    return max_score;
}