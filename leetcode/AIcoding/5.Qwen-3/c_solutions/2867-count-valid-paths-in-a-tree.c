#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
} TreeNode;

typedef struct {
    int size;
    int *data;
} Stack;

Stack* createStack() {
    Stack *s = (Stack*)malloc(sizeof(Stack));
    s->size = 0;
    s->data = NULL;
    return s;
}

void push(Stack *s, int val) {
    s->size++;
    s->data = (int*)realloc(s->data, s->size * sizeof(int));
    s->data[s->size - 1] = val;
}

int pop(Stack *s) {
    int val = s->data[s->size - 1];
    s->size--;
    s->data = (int*)realloc(s->data, s->size * sizeof(int));
    return val;
}

int top(Stack *s) {
    return s->data[s->size - 1];
}

int isEmpty(Stack *s) {
    return s->size == 0;
}

void freeStack(Stack *s) {
    free(s->data);
    free(s);
}

TreeNode* createTreeNode(int val) {
    TreeNode *node = (TreeNode*)malloc(sizeof(TreeNode));
    node->val = val;
    node->left = NULL;
    node->right = NULL;
    return node;
}

void buildTree(TreeNode **root, int *nums, int n, int *index) {
    if (*index >= n || nums[*index] == -1) {
        (*index)++;
        return;
    }
    *root = createTreeNode(nums[*index]);
    (*index)++;
    buildTree(&(*root)->left, nums, n, index);
    buildTree(&(*root)->right, nums, n, index);
}

int countValidPaths(TreeNode *root) {
    int result = 0;
    Stack *stack = createStack();
    stack->data = (int*)malloc(0);
    stack->size = 0;

    Stack *path = createStack();
    path->data = (int*)malloc(0);
    path->size = 0;

    Stack *visited = createStack();
    visited->data = (int*)malloc(0);
    visited->size = 0;

    TreeNode *current = root;
    while (current != NULL || !isEmpty(stack)) {
        while (current != NULL) {
            push(stack, current->val);
            current = current->left;
        }

        current = pop(stack);
        push(path, current);

        if (current->left == NULL && current->right == NULL) {
            int sum = 0;
            for (int i = 0; i < path->size; i++) {
                sum += path->data[i];
            }
            if (sum % 2 == 0) {
                result++;
            }
        }

        current = current->right;
    }

    freeStack(stack);
    freeStack(path);
    freeStack(visited);
    return result;
}