#include <stdlib.h>
#include <string.h>
#include <stdbool.h>

static int* parent;
static int* ranks;

static int find(int i) {
    if (parent[i] == i) {
        return i;
    }
    return parent[i] = find(parent[i]);
}

static void unite(int i, int j) {
    int root_i = find(i);
    int root_j = find(j);
    if (root_i != root_j) {
        if (ranks[root_i] < ranks[root_j]) {
            parent[root_i] = root_j;
        } else if (ranks[root_i] > ranks[root_j]) {
            parent[root_j] = root_i;
        } else {
            parent[root_j] = root_i;
            ranks[root_i]++;
        }
    }
}

static bool isSimilar(char* s1, char* s2) {
    int len = strlen(s1);
    int diff_count = 0;
    int diff_indices[2];

    for (int i = 0; i < len; i++) {
        if (s1[i] != s2[i]) {
            if (diff_count >= 2) {
                return false;
            }
            diff_indices[diff_count++] = i;
        }
    }

    if (diff_count == 0) {
        return true;
    }
    if (diff_count == 2) {
        return (s1[diff_indices[0]] == s2[diff_indices[1]] &&
                s1[diff_indices[1]] == s2[diff_indices[0]]);
    }
    return false;
}

int numSimilarGroups(char** strs, int strsSize) {
    parent = (int*)malloc(strsSize * sizeof(int));
    ranks = (int*)malloc(strsSize * sizeof(int));

    for (int i = 0; i < strsSize; i++) {
        parent[i] = i;
        ranks[i] = 0;
    }

    int num_groups = strsSize;

    for (int i = 0; i < strsSize; i++) {
        for (int j = i + 1; j < strsSize; j++) {
            if (isSimilar(strs[i], strs[j])) {
                int root_i = find(i);
                int root_j = find(j);
                if (root_i != root_j) {
                    unite(i, j); 
                    num_groups--;
                }
            }
        }
    }

    free(parent);
    free(ranks);

    return num_groups;
}