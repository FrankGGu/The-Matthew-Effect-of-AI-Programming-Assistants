#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct UnionFind {
    int* parent;
    int* rank;
    int size;
};

struct UnionFind* createUnionFind(int size) {
    struct UnionFind* uf = (struct UnionFind*)malloc(sizeof(struct UnionFind));
    uf->parent = (int*)malloc(size * sizeof(int));
    uf->rank = (int*)malloc(size * sizeof(int));
    uf->size = size;
    for (int i = 0; i < size; i++) {
        uf->parent[i] = i;
        uf->rank[i] = 1;
    }
    return uf;
}

int find(struct UnionFind* uf, int x) {
    if (uf->parent[x] != x) {
        uf->parent[x] = find(uf, uf->parent[x]);
    }
    return uf->parent[x];
}

void unionSets(struct UnionFind* uf, int x, int y) {
    int rootX = find(uf, x);
    int rootY = find(uf, y);
    if (rootX != rootY) {
        if (uf->rank[rootX] > uf->rank[rootY]) {
            uf->parent[rootY] = rootX;
        } else if (uf->rank[rootX] < uf->rank[rootY]) {
            uf->parent[rootX] = rootY;
        } else {
            uf->parent[rootY] = rootX;
            uf->rank[rootX]++;
        }
    }
}

void addEmailToAccount(char*** accounts, int accountsSize, struct UnionFind* uf, int* emailIndex, char** emails, int accountIndex) {
    for (int i = 1; i < accounts[accountIndex][0] != '\0'; i++) {
        int index = emailIndex[accounts[accountIndex][i][0] - 'a'];
        unionSets(uf, accountIndex, index);
        emails[index] = accounts[accountIndex][i];
    }
}

char*** accountsMerge(char*** accounts, int accountsSize, int* returnSize, int** returnColumnSizes) {
    struct UnionFind* uf = createUnionFind(accountsSize);
    int emailIndex[26] = {0};
    char** emails = (char**)malloc(accountsSize * sizeof(char*));

    for (int i = 0; i < accountsSize; i++) {
        emailIndex[accounts[i][1][0] - 'a'] = i;
        addEmailToAccount(accounts, accountsSize, uf, emailIndex, emails, i);
    }

    int* sizes = (int*)malloc(accountsSize * sizeof(int));
    char*** result = (char***)malloc(accountsSize * sizeof(char**));
    int count = 0;

    for (int i = 0; i < accountsSize; i++) {
        if (find(uf, i) == i) {
            sizes[count] = 0;
            result[count] = (char**)malloc((accountsSize + 1) * sizeof(char*));
            result[count][sizes[count]++] = accounts[i][0];
            for (int j = 0; j < accountsSize; j++) {
                if (find(uf, j) == i) {
                    result[count][sizes[count]++] = accounts[j][1];
                }
            }
            qsort(result[count] + 1, sizes[count] - 1, sizeof(char*), (int (*)(const void*, const void*))strcmp);
            count++;
        }
    }

    *returnSize = count;
    *returnColumnSizes = sizes;
    free(uf->parent);
    free(uf->rank);
    free(uf);
    return result;
}