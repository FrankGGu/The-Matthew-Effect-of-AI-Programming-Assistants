#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    char* email;
    int parent;
} UnionFindNode;

typedef struct {
    char** emails;
    int size;
} EmailList;

typedef struct {
    char* email;
    int index;
} EmailIndex;

int compare(const void* a, const void* b) {
    return strcmp(((EmailIndex*)a)->email, ((EmailIndex*)b)->email);
}

int find(int x, UnionFindNode* uf) {
    if (uf[x].parent != x) {
        uf[x].parent = find(uf[x].parent, uf);
    }
    return uf[x].parent;
}

void unionSet(int x, int y, UnionFindNode* uf) {
    int rootX = find(x, uf);
    int rootY = find(y, uf);
    if (rootX != rootY) {
        uf[rootY].parent = rootX;
    }
}

char** mergeAccounts(char*** accounts, int accountsSize, int* accountsColSize, int** returnSize, int** returnColumnSizes) {
    int totalEmails = 0;
    for (int i = 0; i < accountsSize; i++) {
        totalEmails += accountsColSize[i] - 1;
    }

    EmailIndex* allEmails = (EmailIndex*)malloc(totalEmails * sizeof(EmailIndex));
    int idx = 0;
    for (int i = 0; i < accountsSize; i++) {
        for (int j = 1; j < accountsColSize[i]; j++) {
            allEmails[idx].email = accounts[i][j];
            allEmails[idx].index = i;
            idx++;
        }
    }

    qsort(allEmails, totalEmails, sizeof(EmailIndex), compare);

    UnionFindNode* uf = (UnionFindNode*)malloc(accountsSize * sizeof(UnionFindNode));
    for (int i = 0; i < accountsSize; i++) {
        uf[i].email = accounts[i][0];
        uf[i].parent = i;
    }

    for (int i = 0; i < totalEmails; i++) {
        for (int j = i + 1; j < totalEmails; j++) {
            if (strcmp(allEmails[i].email, allEmails[j].email) == 0) {
                unionSet(allEmails[i].index, allEmails[j].index, uf);
                break;
            }
        }
    }

    int* rootToIndex = (int*)malloc(accountsSize * sizeof(int));
    for (int i = 0; i < accountsSize; i++) {
        rootToIndex[find(i, uf)] = i;
    }

    int count = 0;
    for (int i = 0; i < accountsSize; i++) {
        if (rootToIndex[i] == i) {
            count++;
        }
    }

    char** result = (char**)malloc(count * sizeof(char*));
    *returnSize = count;
    *returnColumnSizes = (int*)malloc(count * sizeof(int));

    int resultIdx = 0;
    for (int i = 0; i < accountsSize; i++) {
        if (rootToIndex[i] == i) {
            int size = 0;
            for (int j = 0; j < accountsSize; j++) {
                if (find(j, uf) == i) {
                    size += accountsColSize[j] - 1;
                }
            }
            (*returnColumnSizes)[resultIdx] = size + 1;
            result[resultIdx] = (char*)malloc((size + 1) * sizeof(char*));
            result[resultIdx][0] = strdup(accounts[i][0]);
            int k = 1;
            for (int j = 0; j < accountsSize; j++) {
                if (find(j, uf) == i) {
                    for (int l = 1; l < accountsColSize[j]; l++) {
                        result[resultIdx][k++] = strdup(accounts[j][l]);
                    }
                }
            }
            resultIdx++;
        }
    }

    free(allEmails);
    free(uf);
    free(rootToIndex);

    return result;
}