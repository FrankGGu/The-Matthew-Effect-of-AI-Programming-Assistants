/**
 * Note: The returned array must be malloced, assume caller calls free().
 */
typedef struct {
    int val;
    int idx;
} Pair;

int cmp(const void* a, const void* b) {
    return ((Pair*)a)->val - ((Pair*)b)->val;
}

int find(int* parent, int x) {
    if (parent[x] != x) {
        parent[x] = find(parent, parent[x]);
    }
    return parent[x];
}

void unionSet(int* parent, int x, int y) {
    int rootX = find(parent, x);
    int rootY = find(parent, y);
    if (rootX != rootY) {
        parent[rootY] = rootX;
    }
}

int* lexicographicallySmallestArray(int* nums, int numsSize, int limit, int* returnSize) {
    *returnSize = numsSize;
    int* res = (int*)malloc(numsSize * sizeof(int));
    int* parent = (int*)malloc(numsSize * sizeof(int));
    for (int i = 0; i < numsSize; i++) {
        parent[i] = i;
    }

    Pair* pairs = (Pair*)malloc(numsSize * sizeof(Pair));
    for (int i = 0; i < numsSize; i++) {
        pairs[i].val = nums[i];
        pairs[i].idx = i;
    }
    qsort(pairs, numsSize, sizeof(Pair), cmp);

    for (int i = 1; i < numsSize; i++) {
        if (pairs[i].val - pairs[i-1].val <= limit) {
            unionSet(parent, pairs[i].idx, pairs[i-1].idx);
        }
    }

    int* groups = (int*)malloc(numsSize * sizeof(int));
    for (int i = 0; i < numsSize; i++) {
        groups[i] = find(parent, i);
    }

    int* groupHeads = (int*)malloc(numsSize * sizeof(int));
    for (int i = 0; i < numsSize; i++) {
        groupHeads[i] = -1;
    }

    for (int i = 0; i < numsSize; i++) {
        int group = groups[i];
        if (groupHeads[group] == -1) {
            groupHeads[group] = i;
        }
    }

    int* indices = (int*)malloc(numsSize * sizeof(int));
    for (int i = 0; i < numsSize; i++) {
        indices[i] = groupHeads[groups[i]]++;
    }

    for (int i = 0; i < numsSize; i++) {
        res[indices[i]] = nums[i];
    }

    free(parent);
    free(pairs);
    free(groups);
    free(groupHeads);
    free(indices);

    return res;
}