#include <stdio.h>
#include <stdlib.h>
#include <limits.h>

typedef struct {
    int val;
    int count;
} Vote;

typedef struct {
    int* data;
    int size;
} SegmentTreeNode;

typedef struct {
    int* nums;
    int n;
    int* freq;
    int* index;
} MajorityElement;

int getMajority(int* nums, int l, int r) {
    int candidate = nums[l];
    int count = 1;
    for (int i = l + 1; i <= r; i++) {
        if (nums[i] == candidate)
            count++;
        else
            count--;
        if (count == 0) {
            candidate = nums[i];
            count = 1;
        }
    }
    return candidate;
}

int isMajority(int* nums, int l, int r, int candidate) {
    int count = 0;
    for (int i = l; i <= r; i++) {
        if (nums[i] == candidate)
            count++;
    }
    return count > (r - l + 1) / 2;
}

SegmentTreeNode* buildSegmentTree(int* nums, int l, int r) {
    if (l == r) {
        SegmentTreeNode* node = (SegmentTreeNode*)malloc(sizeof(SegmentTreeNode));
        node->data = (int*)malloc(2 * sizeof(int));
        node->data[0] = nums[l];
        node->data[1] = 1;
        node->size = 1;
        return node;
    }
    int mid = (l + r) / 2;
    SegmentTreeNode* left = buildSegmentTree(nums, l, mid);
    SegmentTreeNode* right = buildSegmentTree(nums, mid + 1, r);
    SegmentTreeNode* node = (SegmentTreeNode*)malloc(sizeof(SegmentTreeNode));
    node->data = (int*)malloc(2 * sizeof(int));
    node->size = left->size + right->size;
    if (left->data[0] == right->data[0]) {
        node->data[0] = left->data[0];
        node->data[1] = left->data[1] + right->data[1];
    } else {
        if (left->data[1] > right->data[1]) {
            node->data[0] = left->data[0];
            node->data[1] = left->data[1] - right->data[1];
        } else {
            node->data[0] = right->data[0];
            node->data[1] = right->data[1] - left->data[1];
        }
    }
    return node;
}

int querySegmentTree(SegmentTreeNode* node, int l, int r, int ql, int qr) {
    if (qr < l || ql > r)
        return -1;
    if (ql <= l && r <= qr) {
        return node->data[0];
    }
    int mid = (l + r) / 2;
    int leftVal = querySegmentTree(node->left, l, mid, ql, qr);
    int rightVal = querySegmentTree(node->right, mid + 1, r, ql, qr);
    if (leftVal == -1)
        return rightVal;
    if (rightVal == -1)
        return leftVal;
    if (leftVal == rightVal)
        return leftVal;
    return -1;
}

void freeSegmentTree(SegmentTreeNode* node) {
    if (!node)
        return;
    freeSegmentTree(node->left);
    freeSegmentTree(node->right);
    free(node->data);
    free(node);
}

MajorityElement* majorityElementCreate(int* nums, int numsSize) {
    MajorityElement* obj = (MajorityElement*)malloc(sizeof(MajorityElement));
    obj->nums = nums;
    obj->n = numsSize;
    obj->freq = (int*)malloc((obj->n + 1) * sizeof(int));
    obj->index = (int*)malloc((obj->n + 1) * sizeof(int));
    for (int i = 0; i < obj->n; i++) {
        obj->freq[nums[i]] = 0;
    }
    for (int i = 0; i < obj->n; i++) {
        obj->freq[nums[i]]++;
        obj->index[nums[i]] = i;
    }
    return obj;
}

int majorityElementQuery(MajorityElement* obj, int left, int right) {
    int candidate = getMajority(obj->nums, left, right);
    if (isMajority(obj->nums, left, right, candidate))
        return candidate;
    return -1;
}

void majorityElementFree(MajorityElement* obj) {
    free(obj->freq);
    free(obj->index);
    free(obj);
}