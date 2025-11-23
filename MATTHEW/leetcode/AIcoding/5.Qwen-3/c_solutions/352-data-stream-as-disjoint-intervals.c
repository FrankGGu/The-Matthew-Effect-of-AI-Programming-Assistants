#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    int start;
    int end;
} Interval;

typedef struct {
    int* data;
    int size;
    int capacity;
} Vector;

Vector* vector_create() {
    Vector* v = (Vector*)malloc(sizeof(Vector));
    v->data = NULL;
    v->size = 0;
    v->capacity = 0;
    return v;
}

void vector_push(Vector* v, int value) {
    if (v->size == v->capacity) {
        int new_capacity = v->capacity ? v->capacity * 2 : 1;
        int* new_data = (int*)realloc(v->data, new_capacity * sizeof(int));
        v->data = new_data;
        v->capacity = new_capacity;
    }
    v->data[v->size++] = value;
}

void vector_free(Vector* v) {
    free(v->data);
    free(v);
}

typedef struct Node {
    int val;
    struct Node* left;
    struct Node* right;
} Node;

Node* node_create(int val) {
    Node* node = (Node*)malloc(sizeof(Node));
    node->val = val;
    node->left = NULL;
    node->right = NULL;
    return node;
}

void node_free(Node* node) {
    if (node) {
        node_free(node->left);
        node_free(node->right);
        free(node);
    }
}

typedef struct {
    Node* root;
} BST;

BST* bst_create() {
    BST* tree = (BST*)malloc(sizeof(BST));
    tree->root = NULL;
    return tree;
}

void bst_insert(BST* tree, int val) {
    Node* node = tree->root;
    Node* parent = NULL;
    while (node) {
        parent = node;
        if (val < node->val) {
            node = node->left;
        } else {
            node = node->right;
        }
    }
    if (!parent) {
        tree->root = node_create(val);
    } else {
        if (val < parent->val) {
            parent->left = node_create(val);
        } else {
            parent->right = node_create(val);
        }
    }
}

void bst_inorder(Node* node, Vector* result) {
    if (!node) return;
    bst_inorder(node->left, result);
    vector_push(result, node->val);
    bst_inorder(node->right, result);
}

Interval* get_intervals(BST* tree, int* returnSize) {
    Vector* values = vector_create();
    bst_inorder(tree->root, values);
    if (values->size == 0) {
        *returnSize = 0;
        return NULL;
    }
    Interval* intervals = (Interval*)malloc(values->size * sizeof(Interval));
    int count = 0;
    int start = values->data[0];
    for (int i = 1; i < values->size; i++) {
        if (values->data[i] != values->data[i - 1] + 1) {
            intervals[count].start = start;
            intervals[count].end = values->data[i - 1];
            count++;
            start = values->data[i];
        }
    }
    intervals[count].start = start;
    intervals[count].end = values->data[values->size - 1];
    count++;
    *returnSize = count;
    vector_free(values);
    return intervals;
}

typedef struct {
    BST* bst;
} SummaryRanges;

SummaryRanges* summaryRangesCreate() {
    SummaryRanges* obj = (SummaryRanges*)malloc(sizeof(SummaryRanges));
    obj->bst = bst_create();
    return obj;
}

void summaryRangesAddNum(SummaryRanges* obj, int val) {
    bst_insert(obj->bst, val);
}

Interval* summaryRangesGetIntervals(SummaryRanges* obj, int* returnSize) {
    return get_intervals(obj->bst, returnSize);
}

void summaryRangesFree(SummaryRanges* obj) {
    node_free(obj->bst->root);
    free(obj->bst);
    free(obj);
}