#include <stdlib.h>
#include <string.h>

typedef struct {
    char *name;
    char **emails;
    int emailCount;
    int emailCapacity;
} Account;

typedef struct {
    int *parent;
    int *rank;
} UnionFind;

UnionFind* createUnionFind(int size) {
    UnionFind *uf = (UnionFind*)malloc(sizeof(UnionFind));
    uf->parent = (int*)malloc(size * sizeof(int));
    uf->rank = (int*)malloc(size * sizeof(int));
    for (int i = 0; i < size; i++) {
        uf->parent[i] = i;
        uf->rank[i] = 0;
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
        if (uf->rank[rootX] < uf->rank[rootY]) {
            uf->parent[rootX] = rootY;
        } else if (uf->rank[rootX] > uf->rank[rootY]) {
            uf->parent[rootY] = rootX;
        } else {
            uf->parent[rootY] = rootX;
            uf->rank[rootX]++;
        }
    }
}

int cmp(const void *a, const void *b) {
    return strcmp(*(char**)a, *(char**)b);
}

char*** accountsMerge(char*** accounts, int accountsSize, int* accountsColSize, int* returnSize, int** returnColumnSizes) {
    int emailCount = 0;
    for (int i = 0; i < accountsSize; i++) {
        emailCount += accountsColSize[i] - 1;
    }

    char **emails = (char**)malloc(emailCount * sizeof(char*));
    int *emailToAccount = (int*)malloc(emailCount * sizeof(int));
    int *emailIndex = (int*)malloc(emailCount * sizeof(int));

    int idx = 0;
    for (int i = 0; i < accountsSize; i++) {
        for (int j = 1; j < accountsColSize[i]; j++) {
            emails[idx] = accounts[i][j];
            emailToAccount[idx] = i;
            emailIndex[idx] = idx;
            idx++;
        }
    }

    qsort(emailIndex, emailCount, sizeof(int), 
          [](const void *a, const void *b) -> int {
              int i = *(int*)a;
              int j = *(int*)b;
              int cmpResult = strcmp(emails[i], emails[j]);
              if (cmpResult == 0) {
                  return emailToAccount[i] - emailToAccount[j];
              }
              return cmpResult;
          });

    UnionFind *uf = createUnionFind(accountsSize);

    for (int i = 1; i < emailCount; i++) {
        if (strcmp(emails[emailIndex[i]], emails[emailIndex[i-1]]) == 0) {
            unionSets(uf, emailToAccount[emailIndex[i]], emailToAccount[emailIndex[i-1]]);
        }
    }

    int *accountToGroup = (int*)malloc(accountsSize * sizeof(int));
    for (int i = 0; i < accountsSize; i++) {
        accountToGroup[i] = -1;
    }

    int groupCount = 0;
    int *groupRoots = (int*)malloc(accountsSize * sizeof(int));
    for (int i = 0; i < accountsSize; i++) {
        int root = find(uf, i);
        if (accountToGroup[root] == -1) {
            accountToGroup[root] = groupCount;
            groupRoots[groupCount] = root;
            groupCount++;
        }
        accountToGroup[i] = accountToGroup[root];
    }

    Account *mergedAccounts = (Account*)malloc(groupCount * sizeof(Account));
    for (int i = 0; i < groupCount; i++) {
        mergedAccounts[i].name = accounts[groupRoots[i]][0];
        mergedAccounts[i].emailCount = 0;
        mergedAccounts[i].emailCapacity = 10;
        mergedAccounts[i].emails = (char**)malloc(mergedAccounts[i].emailCapacity * sizeof(char*));
    }

    int *visited = (int*)calloc(emailCount, sizeof(int));
    for (int i = 0; i < emailCount; i++) {
        if (visited[i]) continue;

        int accountId = emailToAccount[i];
        int groupId = accountToGroup[accountId];
        Account *acc = &mergedAccounts[groupId];

        for (int j = i; j < emailCount; j++) {
            if (emailToAccount[j] == accountId && !visited[j]) {
                if (acc->emailCount >= acc->emailCapacity) {
                    acc->emailCapacity *= 2;
                    acc->emails = (char**)realloc(acc->emails, acc->emailCapacity * sizeof(char*));
                }
                acc->emails[acc->emailCount++] = emails[j];
                visited[j] = 1;
            }
        }
    }

    for (int i = 0; i < groupCount; i++) {
        qsort(mergedAccounts[i].emails, mergedAccounts[i].emailCount, sizeof(char*), cmp);

        int j = 0;
        for (int k = 1; k < mergedAccounts[i].emailCount; k++) {
            if (strcmp(mergedAccounts[i].emails[j], mergedAccounts[i].emails[k]) != 0) {
                j++;
                mergedAccounts[i].emails[j] = mergedAccounts[i].emails[k];
            }
        }
        mergedAccounts[i].emailCount = j + 1;
    }

    char ***result = (char***)malloc(groupCount * sizeof(char**));
    *returnColumnSizes = (int*)malloc(groupCount * sizeof(int));
    *returnSize = groupCount;

    for (int i = 0; i < groupCount; i++) {
        result[i] = (char**)malloc((mergedAccounts[i].emailCount + 1) * sizeof(char*));
        result[i][0] = mergedAccounts[i].name;
        for (int j = 0; j < mergedAccounts[i].emailCount; j++) {
            result[i][j + 1] = mergedAccounts[i].emails[j];
        }
        (*returnColumnSizes)[i] = mergedAccounts[i].emailCount + 1;
    }

    free(emails);
    free(emailToAccount);
    free(emailIndex);
    free(uf->parent);
    free(uf->rank);
    free(uf);
    free(accountToGroup);
    free(groupRoots);
    for (int i = 0; i < groupCount; i++) {
        free(mergedAccounts[i].emails);
    }
    free(mergedAccounts);
    free(visited);

    return result;
}