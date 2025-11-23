#include <stdlib.h>
#include <string.h>

typedef struct {
    int *parent;
    int *size;
} UnionFind;

UnionFind* createUnionFind(int n) {
    UnionFind *uf = (UnionFind*)malloc(sizeof(UnionFind));
    uf->parent = (int*)malloc(n * sizeof(int));
    uf->size = (int*)malloc(n * sizeof(int));
    for (int i = 0; i < n; i++) {
        uf->parent[i] = i;
        uf->size[i] = 1;
    }
    return uf;
}

int find(UnionFind *uf, int x) {
    if (uf->parent[x] != x) {
        uf->parent[x] = find(uf, uf->parent[x]);
    }
    return uf->parent[x];
}

void unionSets(UnionFind *uf, int x, int y) {
    int rootX = find(uf, x);
    int rootY = find(uf, y);
    if (rootX != rootY) {
        if (uf->size[rootX] < uf->size[rootY]) {
            uf->parent[rootX] = rootY;
            uf->size[rootY] += uf->size[rootX];
        } else {
            uf->parent[rootY] = rootX;
            uf->size[rootX] += uf->size[rootY];
        }
    }
}

void freeUnionFind(UnionFind *uf) {
    free(uf->parent);
    free(uf->size);
    free(uf);
}

int cmp(const void *a, const void *b) {
    return *(char*)a - *(char*)b;
}

char* smallestStringWithSwaps(char* s, int** pairs, int pairsSize, int* pairsColSize) {
    int n = strlen(s);
    UnionFind *uf = createUnionFind(n);

    for (int i = 0; i < pairsSize; i++) {
        unionSets(uf, pairs[i][0], pairs[i][1]);
    }

    int *groups = (int*)malloc(n * sizeof(int));
    for (int i = 0; i < n; i++) {
        groups[i] = find(uf, i);
    }

    int *count = (int*)calloc(n, sizeof(int));
    for (int i = 0; i < n; i++) {
        count[groups[i]]++;
    }

    int **indices = (int**)malloc(n * sizeof(int*));
    char **chars = (char**)malloc(n * sizeof(char*));
    for (int i = 0; i < n; i++) {
        indices[i] = (int*)malloc(count[i] * sizeof(int));
        chars[i] = (char*)malloc(count[i] * sizeof(char));
    }

    int *idx = (int*)calloc(n, sizeof(int));
    for (int i = 0; i < n; i++) {
        int root = groups[i];
        indices[root][idx[root]] = i;
        chars[root][idx[root]] = s[i];
        idx[root]++;
    }

    for (int i = 0; i < n; i++) {
        if (count[i] > 0) {
            qsort(chars[i], count[i], sizeof(char), cmp);
        }
    }

    char *result = (char*)malloc((n + 1) * sizeof(char));
    for (int i = 0; i < n; i++) {
        if (count[i] > 0) {
            for (int j = 0; j < count[i]; j++) {
                result[indices[i][j]] = chars[i][j];
            }
        }
    }
    result[n] = '\0';

    freeUnionFind(uf);
    free(groups);
    free(count);
    free(idx);
    for (int i = 0; i < n; i++) {
        free(indices[i]);
        free(chars[i]);
    }
    free(indices);
    free(chars);

    return result;
}