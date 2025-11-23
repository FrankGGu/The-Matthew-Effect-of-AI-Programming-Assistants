#include <stdio.h>
#include <stdlib.h>

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

int* findTarget(struct TreeNode* root, int target, int* returnSize) {
    int* result = (int*)malloc(2 * sizeof(int));
    *returnSize = 0;

    typedef struct {
        int size;
        int capacity;
        int* data;
    } Set;

    Set* set = (Set*)malloc(sizeof(Set));
    set->size = 0;
    set->capacity = 1;
    set->data = (int*)malloc(set->capacity * sizeof(int));

    struct TreeNode* stack[1000];
    int top = -1;
    struct TreeNode* current = root;

    while (current || top >= 0) {
        while (current) {
            stack[++top] = current;
            current = current->left;
        }

        current = stack[top--];
        int complement = target - current->val;

        int found = 0;
        for (int i = 0; i < set->size; i++) {
            if (set->data[i] == complement) {
                found = 1;
                break;
            }
        }

        if (found) {
            result[0] = complement;
            result[1] = current->val;
            *returnSize = 2;
            free(set->data);
            free(set);
            return result;
        }

        if (set->size == set->capacity) {
            set->capacity *= 2;
            set->data = (int*)realloc(set->data, set->capacity * sizeof(int));
        }
        set->data[set->size++] = current->val;

        current = current->right;
    }

    free(set->data);
    free(set);
    return result;
}