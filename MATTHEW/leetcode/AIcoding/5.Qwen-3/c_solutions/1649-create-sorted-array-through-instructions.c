#include <stdio.h>
#include <stdlib.h>

typedef struct {
    int *tree;
    int size;
} SegmentTree;

SegmentTree* createSegmentTree(int size) {
    SegmentTree *st = (SegmentTree*)malloc(sizeof(SegmentTree));
    st->size = 1;
    while (st->size < size) st->size <<= 1;
    st->tree = (int*)calloc(st->size * 2, sizeof(int));
    return st;
}

void update(SegmentTree *st, int index, int value) {
    index += st->size;
    st->tree[index] += value;
    while (index > 1) {
        index >>= 1;
        st->tree[index] = st->tree[2 * index] + st->tree[2 * index + 1];
    }
}

int query(SegmentTree *st, int l, int r) {
    int res = 0;
    l += st->size;
    r += st->size;
    while (l <= r) {
        if (l % 2 == 1) res += st->tree[l], l++;
        if (r % 2 == 0) res += st->tree[r], r--;
        l >>= 1;
        r >>= 1;
    }
    return res;
}

int* createSortedArray(int* instructions, int instructionsSize, int* returnSize) {
    int max_val = 0;
    for (int i = 0; i < instructionsSize; i++) {
        if (instructions[i] > max_val) max_val = instructions[i];
    }
    SegmentTree *st = createSegmentTree(max_val + 1);
    int *result = (int*)calloc(instructionsSize, sizeof(int));
    int total = 0;
    for (int i = 0; i < instructionsSize; i++) {
        int val = instructions[i];
        int less = query(st, 0, val - 1);
        int greater = query(st, val + 1, max_val);
        result[i] = less < greater ? less : greater;
        total += result[i];
        update(st, val, 1);
    }
    *returnSize = instructionsSize;
    free(st->tree);
    free(st);
    return result;
}