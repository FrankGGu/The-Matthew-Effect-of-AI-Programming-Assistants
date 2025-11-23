#include <stdio.h>
#include <stdlib.h>

typedef struct {
    int person;
    int time;
} Pair;

int compare(const void *a, const void *b) {
    Pair *p1 = (Pair *)a;
    Pair *p2 = (Pair *)b;
    return p1->time - p2->time;
}

int* findAllPeople(int n, int** meetings, int meetingsSize, int* meetingsColSize, int* returnSize) {
    int* result = (int*)malloc(n * sizeof(int));
    int resultSize = 0;
    int* parent = (int*)malloc(n * sizeof(int));

    for (int i = 0; i < n; i++) {
        parent[i] = i;
    }

    for (int i = 0; i < meetingsSize; i++) {
        int u = meetings[i][0];
        int v = meetings[i][1];
        int t = meetings[i][2];
        if (u > v) {
            int temp = u;
            u = v;
            v = temp;
        }
        meetings[i][0] = u;
        meetings[i][1] = v;
    }

    qsort(meetings, meetingsSize, sizeof(int*), compare);

    int i = 0;
    while (i < meetingsSize) {
        int current_time = meetings[i][2];
        int j = i;
        while (j < meetingsSize && meetings[j][2] == current_time) {
            j++;
        }

        int* group = (int*)malloc((j - i) * sizeof(int));
        int groupSize = 0;

        for (int k = i; k < j; k++) {
            int u = meetings[k][0];
            int v = meetings[k][1];
            group[groupSize++] = u;
            group[groupSize++] = v;
        }

        for (int k = 0; k < groupSize; k += 2) {
            int a = group[k];
            int b = group[k + 1];
            int rootA = a;
            while (parent[rootA] != rootA) {
                rootA = parent[rootA];
            }
            int rootB = b;
            while (parent[rootB] != rootB) {
                rootB = parent[rootB];
            }
            if (rootA != rootB) {
                parent[rootA] = rootB;
            }
        }

        int* visited = (int*)calloc(n, sizeof(int));
        for (int k = 0; k < groupSize; k++) {
            int x = group[k];
            int rootX = x;
            while (parent[rootX] != rootX) {
                rootX = parent[rootX];
            }
            if (!visited[rootX]) {
                visited[rootX] = 1;
                result[resultSize++] = rootX;
            }
        }

        free(visited);
        free(group);
        i = j;
    }

    free(parent);
    *returnSize = resultSize;
    return result;
}