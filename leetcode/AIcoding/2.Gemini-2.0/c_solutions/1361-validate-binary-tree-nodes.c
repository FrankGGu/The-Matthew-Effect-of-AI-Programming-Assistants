#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool validateBinaryTreeNodes(int n, int* leftChild, int leftChildSize, int* rightChild, int rightChildSize) {
    int* inDegree = (int*)calloc(n, sizeof(int));
    for (int i = 0; i < n; i++) {
        if (leftChild[i] != -1) {
            if (leftChild[i] < 0 || leftChild[i] >= n) {
                free(inDegree);
                return false;
            }
            inDegree[leftChild[i]]++;
        }
        if (rightChild[i] != -1) {
            if (rightChild[i] < 0 || rightChild[i] >= n) {
                free(inDegree);
                return false;
            }
            inDegree[rightChild[i]]++;
        }
    }

    int rootCount = 0;
    int root = -1;
    for (int i = 0; i < n; i++) {
        if (inDegree[i] == 0) {
            rootCount++;
            root = i;
        }
    }

    if (rootCount != 1) {
        free(inDegree);
        return false;
    }

    bool* visited = (bool*)calloc(n, sizeof(bool));
    int count = 0;
    int* queue = (int*)malloc(n * sizeof(int));
    int head = 0, tail = 0;
    queue[tail++] = root;
    visited[root] = true;
    count++;

    while (head < tail) {
        int node = queue[head++];

        if (leftChild[node] != -1) {
            if (visited[leftChild[node]]) {
                free(inDegree);
                free(visited);
                free(queue);
                return false;
            }
            visited[leftChild[node]] = true;
            queue[tail++] = leftChild[node];
            count++;
        }

        if (rightChild[node] != -1) {
            if (visited[rightChild[node]]) {
                free(inDegree);
                free(visited);
                free(queue);
                return false;
            }
            visited[rightChild[node]] = true;
            queue[tail++] = rightChild[node];
            count++;
        }
    }

    free(inDegree);
    free(visited);
    free(queue);

    return count == n;
}