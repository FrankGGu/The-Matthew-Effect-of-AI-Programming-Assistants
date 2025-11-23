#include <stdbool.h>
#include <stdlib.h>

bool validateBinaryTreeNodes(int n, int* leftChild, int leftChildSize, int* rightChild, int rightChildSize) {
    int* inDegree = (int*)calloc(n, sizeof(int));
    if (inDegree == NULL) {
        return false;
    }

    for (int i = 0; i < n; i++) {
        if (leftChild[i] != -1) {
            inDegree[leftChild[i]]++;
            if (inDegree[leftChild[i]] > 1) {
                free(inDegree);
                return false;
            }
        }
        if (rightChild[i] != -1) {
            inDegree[rightChild[i]]++;
            if (inDegree[rightChild[i]] > 1) {
                free(inDegree);
                return false;
            }
        }
    }

    int root = -1;
    int rootCount = 0;
    for (int i = 0; i < n; i++) {
        if (inDegree[i] == 0) {
            root = i;
            rootCount++;
        }
    }

    free(inDegree);

    if (rootCount != 1) {
        return false;
    }

    bool* visited = (bool*)calloc(n, sizeof(bool));
    if (visited == NULL) {
        return false;
    }

    int* queue = (int*)malloc(n * sizeof(int));
    if (queue == NULL) {
        free(visited);
        return false;
    }
    int head = 0;
    int tail = 0;

    queue[tail++] = root;
    visited[root] = true;
    int visitedCount = 0;

    while (head < tail) {
        int u = queue[head++];
        visitedCount++;

        int v_left = leftChild[u];
        if (v_left != -1) {
            if (visited[v_left]) {
                free(visited);
                free(queue);
                return false;
            }
            visited[v_left] = true;
            queue[tail++] = v_left;
        }

        int v_right = rightChild[u];
        if (v_right != -1) {
            if (visited[v_right]) {
                free(visited);
                free(queue);
                return false;
            }
            visited[v_right] = true;
            queue[tail++] = v_right;
        }
    }

    free(visited);
    free(queue);

    return visitedCount == n;
}