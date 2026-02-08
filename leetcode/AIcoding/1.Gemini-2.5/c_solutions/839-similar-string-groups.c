#include <stdbool.h>
#include <string.h>
#include <stdlib.h>

static int* parent;
static int* rank_arr;

static void dsu_init(int n) {
    parent = (int*)malloc(sizeof(int) * n);
    rank_arr = (int*)malloc(sizeof(int) * n);
    for (int i = 0; i < n; ++i) {
        parent[i] = i;
        rank_arr[i] = 0;
    }
}

static int dsu_find(int i) {
    if (parent[i] == i) {
        return i;
    }
    return parent[i] = dsu_find(parent[i]);
}

static void dsu_unite(int i, int j) {
    int root_i = dsu_find(i);
    int root_j = dsu_find(j);

    if (root_i != root_j) {
        if (rank_arr[root_i] < rank_arr[root_j]) {
            parent[root_i] = root_j;
        } else if (rank_arr[root_i] > rank_arr[root_j]) {
            parent[root_j] = root_i;
        } else {
            parent[root_j] = root_i;
            rank_arr[root_i]++;
        }
    }
}

static bool areSimilar(char* s1, char* s2) {
    int len = strlen(s1);
    int diff_indices[2];
    int diff_count = 0;

    for (int i = 0; i < len; ++i) {
        if (s1[i] != s2[i]) {
            if (diff_count < 2) {
                diff_indices[diff_count] = i;
            }
            diff_count++;
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
    if (strsSize == 0) {
        return 0;
    }

    dsu_init(strsSize);

    for (int i = 0; i < strsSize; ++i) {
        for (int j = i + 1; j < strsSize; ++j) {
            if (areSimilar(strs[i], strs[j])) {
                dsu_unite(i, j);
            }
        }
    }

    int num_groups = 0;
    for (int i = 0; i < strsSize; ++i) {
        if (parent[i] == i) {
            num_groups++;
        }
    }

    free(parent);
    free(rank_arr);

    return num_groups;
}