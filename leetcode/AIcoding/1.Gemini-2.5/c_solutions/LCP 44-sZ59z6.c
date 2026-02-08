#include <stdlib.h> // For malloc, realloc, free, qsort

typedef struct Node {
    int val;
    int numChildren;
    struct Node** children;
} Node;

void collectValues(Node* root, int** values, int* size, int* capacity) {
    if (root == NULL) {
        return;
    }

    if (*size == *capacity) {
        *capacity *= 2;
        *values = (int*)realloc(*values, sizeof(int) * (*capacity));
    }
    (*values)[(*size)++] = root->val;

    for (int i = 0; i < root->numChildren; i++) {
        collectValues(root->children[i], values, size, capacity);
    }
}

int compare(const void* a, const void* b) {
    return (*(int*)a - *(int*)b);
}

int uniqueValues(Node* root) {
    if (root == NULL) {
        return 0;
    }

    int* values = NULL;
    int size = 0;
    int capacity = 100;
    values = (int*)malloc(sizeof(int) * capacity);

    collectValues(root, &values, &size, &capacity);

    if (size == 0) {
        free(values);
        return 0;
    }

    qsort(values, size, sizeof(int), compare);

    int uniqueCount = 0;
    if (size > 0) {
        uniqueCount = 1;
        for (int i = 1; i < size; i++) {
            if (values[i] != values[i-1]) {
                uniqueCount++;
            }
        }
    }

    free(values);
    return uniqueCount;
}