#include <stdlib.h>
#include <string.h>

typedef struct {
    int* tree;
    int size;
} SegmentTree;

SegmentTree* createSegmentTree(int n) {
    SegmentTree* segTree = (SegmentTree*)malloc(sizeof(SegmentTree));
    segTree->size = n;
    segTree->tree = (int*)calloc(4 * n, sizeof(int));
    return segTree;
}

void build(SegmentTree* segTree, int idx, int left, int right, int* arr) {
    if (left == right) {
        segTree->tree[idx] = arr[left];
        return;
    }
    int mid = left + (right - left) / 2;
    build(segTree, 2 * idx + 1, left, mid, arr);
    build(segTree, 2 * idx + 2, mid + 1, right, arr);
    segTree->tree[idx] = segTree->tree[2 * idx + 1] ^ segTree->tree[2 * idx + 2];
}

int query(SegmentTree* segTree, int idx, int left, int right, int ql, int qr) {
    if (ql > right || qr < left) return 0;
    if (ql <= left && qr >= right) return segTree->tree[idx];
    int mid = left + (right - left) / 2;
    int leftXor = query(segTree, 2 * idx + 1, left, mid, ql, qr);
    int rightXor = query(segTree, 2 * idx + 2, mid + 1, right, ql, qr);
    return leftXor ^ rightXor;
}

void freeSegmentTree(SegmentTree* segTree) {
    free(segTree->tree);
    free(segTree);
}

int* maximumXorSubarray(int* nums, int numsSize, int** queries, int queriesSize, int* queriesColSize, int* returnSize) {
    *returnSize = queriesSize;
    int* result = (int*)malloc(queriesSize * sizeof(int));

    SegmentTree* segTree = createSegmentTree(numsSize);
    build(segTree, 0, 0, numsSize - 1, nums);

    for (int i = 0; i < queriesSize; i++) {
        int l = queries[i][0];
        int r = queries[i][1];
        int maxXor = 0;

        for (int j = l; j <= r; j++) {
            for (int k = j; k <= r; k++) {
                int xorVal = query(segTree, 0, 0, numsSize - 1, j, k);
                if (xorVal > maxXor) {
                    maxXor = xorVal;
                }
            }
        }
        result[i] = maxXor;
    }

    freeSegmentTree(segTree);
    return result;
}